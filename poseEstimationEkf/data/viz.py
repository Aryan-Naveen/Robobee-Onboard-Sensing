import matplotlib.pyplot as plt
import numpy as np

output = []

truth = np.genfromtxt("/home/anaveen/Documents/harvard_ws/research/Robobee-Onboard-Sensing/poseEstimationEkf/data/ToF_test.csv",
                    delimiter=",", dtype=float)

print(truth)
t = truth[:, 0]

true_z = [abs(val) for val in truth[:, -2]]

file = open('data.txt', 'r')
data = file.read().splitlines()[5:]
dt = 20
t = np.arange(0, dt*len(data), dt)
for d in data:
    output.append([float(val) for val in d.split(' ')])

output = np.array(output)
fig, axs = plt.subplots(1, 1)
# axs.plot(t, output[:, 0], color='r', alpha = 0.3, label=r'$\omega_x$')
# axs.plot(t, output[:, 1], color ='r', alpha = 0.3, label=r'$\omega_y$')
# axs.plot(t, output[:, 2], color = 'r', alpha=0.3, label=r'$\omega_z$')
# axs.plot(t, output[:, 3], color='orange', alpha = 0.3, label=r'$a_x$')
# axs.plot(t, output[:, 4], color ='orange', alpha = 0.3, label=r'$a_y$')
# axs.plot(t, output[:, 5], color = 'orange', alpha=0.3, label=r'$a_z$')
# axs.plot(t, np.unwrap(output[:, 6]) - np.pi, color='red', alpha = 1, label=r'$\theta_x$')
# axs.plot(t, np.unwrap(output[:, 7]), color ='green', alpha = 1, label=r'$\theta_y$')
# axs.plot(t, np.unwrap(output[:, 8]), color = 'blue', alpha=1, label=r'$\theta_z$')

# axs.plot(t, [abs(val) for val in output[:, 9]], label=r'TOF distance')
axs.plot(t, [abs(val) for val in output[:, 10]], label=r'estimated height')
print(true_z)
axs.plot(t, [abs(val) for val in true_z], label=r'estimated height')
axs.set_xlabel('Milliseconds')
axs.legend()
plt.show()
file.close()
