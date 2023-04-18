#include "Adafruit_VL53L1X.h"
#include <LSM6DS3.h>
#include <Wire.h>
#include <elapsedMillis.h>
#include "config.h"
#include "matrix.h"
#include "ekf.h"



/* ================================================= RLS Variables/function declaration ================================================= */
float_prec  RLS_lambda = 0.999; /* Forgetting factor */
Matrix RLS_theta(4,1);          /* The variables we want to indentify */
Matrix RLS_P(4,4);              /* Inverse of correction estimation */
Matrix RLS_in(4,1);             /* Input data */
Matrix RLS_out(1,1);            /* Output data */
Matrix RLS_gain(4,1);           /* RLS gain */
uint32_t RLS_u32iterData = 0;   /* To track how much data we take */


/* ================================================= EKF Variables/function declaration ================================================= */
/* EKF initialization constant */
#define P_INIT      (10.)
#define Q_INIT      (1e-6)
#define R_INIT_ACC  (100/10.)
#define R_INIT_MAG  (0.0015/10.)
/* P(k=0) variable --------------------------------------------------------------------------------------------------------- */
float_prec EKF_PINIT_data[SS_X_LEN*SS_X_LEN] = {P_INIT, 0,      0,      0,
                                                0,      P_INIT, 0,      0,
                                                0,      0,      P_INIT, 0,
                                                0,      0,      0,      P_INIT};
Matrix EKF_PINIT(SS_X_LEN, SS_X_LEN, EKF_PINIT_data);
/* Q constant -------------------------------------------------------------------------------------------------------------- */
float_prec EKF_QINIT_data[SS_X_LEN*SS_X_LEN] = {Q_INIT, 0,      0,      0,
                                                0,      Q_INIT, 0,      0,
                                                0,      0,      Q_INIT, 0,
                                                0,      0,      0,      Q_INIT};
Matrix EKF_QINIT(SS_X_LEN, SS_X_LEN, EKF_QINIT_data);
/* R constant -------------------------------------------------------------------------------------------------------------- */
float_prec EKF_RINIT_data[SS_Z_LEN*SS_Z_LEN] = {R_INIT_ACC, 0,          0,
                                                0,          R_INIT_ACC, 0,
                                                0,          0,          R_INIT_ACC};

Matrix EKF_RINIT(SS_Z_LEN, SS_Z_LEN, EKF_RINIT_data);
/* Nonlinear & linearization function -------------------------------------------------------------------------------------- */
bool Main_bUpdateNonlinearX(Matrix &X_Next, Matrix &X, Matrix &U);
bool Main_bUpdateNonlinearY(Matrix &Y, Matrix &X, Matrix &U);
bool Main_bCalcJacobianF(Matrix &F, Matrix &X, Matrix &U);
bool Main_bCalcJacobianH(Matrix &H, Matrix &X, Matrix &U);
/* EKF variables ----------------------------------------------------------------------------------------------------------- */
Matrix quaternionData(SS_X_LEN, 1);
Matrix Y(SS_Z_LEN, 1);
Matrix U(SS_U_LEN, 1);
EKF EKF_IMU(quaternionData, EKF_PINIT, EKF_QINIT, EKF_RINIT,
            Main_bUpdateNonlinearX, Main_bUpdateNonlinearY, Main_bCalcJacobianF, Main_bCalcJacobianH);



/* =============================================== Sharing Variables/function declaration =============================================== */
/* Gravity vector constant (align with global Z-axis) */
#define IMU_ACC_Z0          (1)


/* State machine for hard-iron bias identification or EKF running */
enum {
    STATE_EKF_RUNNING = 0,
    STATE_MAGNETO_BIAS_IDENTIFICATION,
    STATE_NORTH_VECTOR_IDENTIFICATION
} STATE_AHRS;


#define IRQ_PIN 2

#define XSHUT_PIN 3

LSM6DS3 myIMU(I2C_MODE, 0x6A);    //I2C device address 0x6A
float aX, aY, aZ, gX, gY, gZ;
int16_t distance = 0;
Adafruit_VL53L1X vl53 = Adafruit_VL53L1X(XSHUT_PIN, IRQ_PIN);

/* ============================================== Auxiliary Variables/function declaration ============================================== */
elapsedMillis timerCollectData = 0;
uint64_t u64compuTime;
char bufferTxSer[100];
void serialFloatPrint(float f);


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  while(!Serial) {}
  Wire.begin();

  if (! vl53.begin(0x29, &Wire)) {
    Serial.print(F("Error on init of VL sensor: "));
    Serial.println(vl53.vl_status);
    while (1)       delay(10);
  }
  Serial.println(F("VL53L1X sensor OK!"));
  if (! vl53.startRanging()) {
    Serial.print(F("Couldn't start ranging: "));
    Serial.println(vl53.vl_status);
    while (1)       delay(10);
  }
  Serial.println(F("Ranging started"));
  vl53.setTimingBudget(50);
  Serial.print(F("Timing budget (ms): "));
  Serial.println(vl53.getTimingBudget());
  if (myIMU.begin() != 0) {
    Serial.println("Device error");
  }

  /* RLS initialization ----------------------------------------- */
  RLS_theta.vSetToZero();
  RLS_P.vSetIdentity();
  RLS_P = RLS_P * 1000;

  /* EKF initialization ----------------------------------------- */
  /* x(k=0) = [1 0 0 0]' */
  quaternionData.vSetToZero();
  quaternionData[0][0] = 1.0;
  EKF_IMU.vReset(quaternionData, EKF_PINIT, EKF_QINIT, EKF_RINIT);

  snprintf(bufferTxSer, sizeof(bufferTxSer)-1, "EKF in Teensy 4.0 (%s)\r\n", (FPU_PRECISION == PRECISION_SINGLE)?"Float32":"Double64");
  Serial.print(bufferTxSer);

}

int count = 0;
void loop() {
  // put your main code here, to run repeatedly:
  if (vl53.dataReady()) {
    distance = vl53.distance();

    aX= myIMU.readFloatAccelX(); aY = myIMU.readFloatAccelY(); aZ = myIMU.readFloatAccelZ();
    gX = myIMU.readFloatGyroX(); gY = myIMU.readFloatGyroY(); gZ = myIMU.readFloatGyroZ();

    U[0][0] = gX; U[1][0] = gY; U[2][0] = gZ;
    Y[0][0] = aX; Y[1][0] = aY; Y[2][0] = aZ;

    // Normalize output vector
    float_prec _normY = sqrt(Y[0][0]*Y[0][0] + Y[1][0]*Y[1][0] + Y[2][0]*Y[2][0]);
    Y[0][0] = Y[0][0]/_normY;
    Y[1][0] = Y[1][0]/_normY;
    Y[2][0] = Y[2][0]/_normY;

    if(!EKF_IMU.bUpdate(Y, U)) {
      quaternionData.vSetToZero();
      quaternionData[0][0] = 1.0;
      EKF_IMU.vReset(quaternionData, EKF_PINIT, EKF_QINIT, EKF_RINIT);
      Serial.println("whoops");
    }
    quaternionData = EKF_IMU.GetX();

    if(!(count % 100)){
      Serial.print(aX, 3);
      Serial.print(",");
      Serial.print(aY, 3);
      Serial.print(",");
      Serial.print(aZ, 3);
      Serial.print(",");
      Serial.print(quaternionData[3][0], 3);
      Serial.println("");      
    }
    count ++;

  }
}

void serialFloatPrint(float f) {
    byte * b = (byte *) &f;
    for (int i = 0; i < 4; i++) {
        byte b1 = (b[i] >> 4) & 0x0f;
        byte b2 = (b[i] & 0x0f);

        char c1 = (b1 < 10) ? ('0' + b1) : 'A' + b1 - 10;
        char c2 = (b2 < 10) ? ('0' + b2) : 'A' + b2 - 10;

        Serial.print(c1);
        Serial.print(c2);
    }
}

bool Main_bUpdateNonlinearX(Matrix &X_Next, Matrix &X, Matrix &U)
{
    /* Insert the nonlinear update transformation here
     *          x(k+1) = f[x(k), u(k)]
     *
     * The quaternion update function:
     *  q0_dot = 1/2. * (  0   - p*q1 - q*q2 - r*q3)
     *  q1_dot = 1/2. * ( p*q0 +   0  + r*q2 - q*q3)
     *  q2_dot = 1/2. * ( q*q0 - r*q1 +  0   + p*q3)
     *  q3_dot = 1/2. * ( r*q0 + q*q1 - p*q2 +  0  )
     *
     * Euler method for integration:
     *  q0 = q0 + q0_dot * dT;
     *  q1 = q1 + q1_dot * dT;
     *  q2 = q2 + q2_dot * dT;
     *  q3 = q3 + q3_dot * dT;
     */
    float_prec q0, q1, q2, q3;
    float_prec p, q, r;

    q0 = X[0][0];
    q1 = X[1][0];
    q2 = X[2][0];
    q3 = X[3][0];

    p = U[0][0];
    q = U[1][0];
    r = U[2][0];

    X_Next[0][0] = (0.5 * (+0.00 -p*q1 -q*q2 -r*q3))*SS_DT + q0;
    X_Next[1][0] = (0.5 * (+p*q0 +0.00 +r*q2 -q*q3))*SS_DT + q1;
    X_Next[2][0] = (0.5 * (+q*q0 -r*q1 +0.00 +p*q3))*SS_DT + q2;
    X_Next[3][0] = (0.5 * (+r*q0 +q*q1 -p*q2 +0.00))*SS_DT + q3;


    /* ======= Additional ad-hoc quaternion normalization to make sure the quaternion is a unit vector (i.e. ||q|| = 1) ======= */
    if (!X_Next.bNormVector()) {
        /* System error, return false so we can reset the UKF */
        return false;
    }

    return true;
}

bool Main_bUpdateNonlinearY(Matrix &Y, Matrix &X, Matrix &U)
{
    /* Insert the nonlinear measurement transformation here
     *          y(k)   = h[x(k), u(k)]
     *
     * The measurement output is the gravitational and magnetic projection to the body
     *     DCM     = [(+(q0**2)+(q1**2)-(q2**2)-(q3**2)),                        2*(q1*q2+q0*q3),                        2*(q1*q3-q0*q2)]
     *               [                   2*(q1*q2-q0*q3),     (+(q0**2)-(q1**2)+(q2**2)-(q3**2)),                        2*(q2*q3+q0*q1)]
     *               [                   2*(q1*q3+q0*q2),                        2*(q2*q3-q0*q1),     (+(q0**2)-(q1**2)-(q2**2)+(q3**2))]
     *
     *  G_proj_sens = DCM * [0 0 1]             --> Gravitational projection to the accelerometer sensor
     *  M_proj_sens = DCM * [Mx My Mz]          --> (Earth) magnetic projection to the magnetometer sensor
     */
    float_prec q0, q1, q2, q3;
    float_prec q0_2, q1_2, q2_2, q3_2;

    q0 = X[0][0];
    q1 = X[1][0];
    q2 = X[2][0];
    q3 = X[3][0];

    q0_2 = q0 * q0;
    q1_2 = q1 * q1;
    q2_2 = q2 * q2;
    q3_2 = q3 * q3;

    Y[0][0] = (2*q1*q3 -2*q0*q2) * IMU_ACC_Z0;

    Y[1][0] = (2*q2*q3 +2*q0*q1) * IMU_ACC_Z0;

    Y[2][0] = (+(q0_2) -(q1_2) -(q2_2) +(q3_2)) * IMU_ACC_Z0;

    // Y[3][0] = (+(q0_2)+(q1_2)-(q2_2)-(q3_2)) * IMU_MAG_B0[0][0]
    //          +(2*(q1*q2+q0*q3)) * IMU_MAG_B0[1][0]
    //          +(2*(q1*q3-q0*q2)) * IMU_MAG_B0[2][0];
    //
    // Y[4][0] = (2*(q1*q2-q0*q3)) * IMU_MAG_B0[0][0]
    //          +(+(q0_2)-(q1_2)+(q2_2)-(q3_2)) * IMU_MAG_B0[1][0]
    //          +(2*(q2*q3+q0*q1)) * IMU_MAG_B0[2][0];
    //
    // Y[5][0] = (2*(q1*q3+q0*q2)) * IMU_MAG_B0[0][0]
    //          +(2*(q2*q3-q0*q1)) * IMU_MAG_B0[1][0]
    //          +(+(q0_2)-(q1_2)-(q2_2)+(q3_2)) * IMU_MAG_B0[2][0];
    return true;
}

bool Main_bCalcJacobianF(Matrix &F, Matrix &X, Matrix &U)
{
    /* In Main_bUpdateNonlinearX():
     *  q0 = q0 + q0_dot * dT;
     *  q1 = q1 + q1_dot * dT;
     *  q2 = q2 + q2_dot * dT;
     *  q3 = q3 + q3_dot * dT;
     */
    float_prec p, q, r;

    p = U[0][0];
    q = U[1][0];
    r = U[2][0];

    F[0][0] =  1.000;
    F[1][0] =  0.5*p * SS_DT;
    F[2][0] =  0.5*q * SS_DT;
    F[3][0] =  0.5*r * SS_DT;

    F[0][1] = -0.5*p * SS_DT;
    F[1][1] =  1.000;
    F[2][1] = -0.5*r * SS_DT;
    F[3][1] =  0.5*q * SS_DT;

    F[0][2] = -0.5*q * SS_DT;
    F[1][2] =  0.5*r * SS_DT;
    F[2][2] =  1.000;
    F[3][2] = -0.5*p * SS_DT;

    F[0][3] = -0.5*r * SS_DT;
    F[1][3] = -0.5*q * SS_DT;
    F[2][3] =  0.5*p * SS_DT;
    F[3][3] =  1.000;

    return true;
}

bool Main_bCalcJacobianH(Matrix &H, Matrix &X, Matrix &U)
{
    float_prec q0, q1, q2, q3;

    q0 = X[0][0];
    q1 = X[1][0];
    q2 = X[2][0];
    q3 = X[3][0];

    H[0][0] = -2*q2 * IMU_ACC_Z0;
    H[1][0] = +2*q1 * IMU_ACC_Z0;
    H[2][0] = +2*q0 * IMU_ACC_Z0;
    // H[3][0] =  2*q0*IMU_MAG_B0[0][0] + 2*q3*IMU_MAG_B0[1][0] - 2*q2*IMU_MAG_B0[2][0];
    // H[4][0] = -2*q3*IMU_MAG_B0[0][0] + 2*q0*IMU_MAG_B0[1][0] + 2*q1*IMU_MAG_B0[2][0];
    // H[5][0] =  2*q2*IMU_MAG_B0[0][0] - 2*q1*IMU_MAG_B0[1][0] + 2*q0*IMU_MAG_B0[2][0];

    H[0][1] = +2*q3 * IMU_ACC_Z0;
    H[1][1] = +2*q0 * IMU_ACC_Z0;
    H[2][1] = -2*q1 * IMU_ACC_Z0;
    // H[3][1] =  2*q1*IMU_MAG_B0[0][0]+2*q2*IMU_MAG_B0[1][0] + 2*q3*IMU_MAG_B0[2][0];
    // H[4][1] =  2*q2*IMU_MAG_B0[0][0]-2*q1*IMU_MAG_B0[1][0] + 2*q0*IMU_MAG_B0[2][0];
    // H[5][1] =  2*q3*IMU_MAG_B0[0][0]-2*q0*IMU_MAG_B0[1][0] - 2*q1*IMU_MAG_B0[2][0];

    H[0][2] = -2*q0 * IMU_ACC_Z0;
    H[1][2] = +2*q3 * IMU_ACC_Z0;
    H[2][2] = -2*q2 * IMU_ACC_Z0;
    // H[3][2] = -2*q2*IMU_MAG_B0[0][0]+2*q1*IMU_MAG_B0[1][0] - 2*q0*IMU_MAG_B0[2][0];
    // H[4][2] =  2*q1*IMU_MAG_B0[0][0]+2*q2*IMU_MAG_B0[1][0] + 2*q3*IMU_MAG_B0[2][0];
    // H[5][2] =  2*q0*IMU_MAG_B0[0][0]+2*q3*IMU_MAG_B0[1][0] - 2*q2*IMU_MAG_B0[2][0];

    H[0][3] = +2*q1 * IMU_ACC_Z0;
    H[1][3] = +2*q2 * IMU_ACC_Z0;
    H[2][3] = +2*q3 * IMU_ACC_Z0;
    // H[3][3] = -2*q3*IMU_MAG_B0[0][0]+2*q0*IMU_MAG_B0[1][0] + 2*q1*IMU_MAG_B0[2][0];
    // H[4][3] = -2*q0*IMU_MAG_B0[0][0]-2*q3*IMU_MAG_B0[1][0] + 2*q2*IMU_MAG_B0[2][0];
    // H[5][3] =  2*q1*IMU_MAG_B0[0][0]+2*q2*IMU_MAG_B0[1][0] + 2*q3*IMU_MAG_B0[2][0];

    return true;
}

void SPEW_THE_ERROR(char const * str)
{
    #if (SYSTEM_IMPLEMENTATION == SYSTEM_IMPLEMENTATION_PC)
        cout << (str) << endl;
    #elif (SYSTEM_IMPLEMENTATION == SYSTEM_IMPLEMENTATION_EMBEDDED_ARDUINO)
        Serial.println(str);
    #else
        /* Silent function */
    #endif
    while(1);
}
