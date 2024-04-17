classdef uavTOF < uav.SensorAdaptor
    %uavTOF Adaptor that specifies behavior of tofSensor in uavScenario
        
    properties
        %UpdateRate Sensor Update Rate
        MountingAngles
        MountingLocation
        AzimuthLimits
        UpdateRate = 100;
    end
    
    methods
        function s = get.UpdateRate(obj)
            s = obj.SensorModel.UpdateRate;
        end
        
        function set.UpdateRate(obj, s)
            obj.SensorModel.UpdateRate = s;
        end

        function s = get.MountingAngles(obj)
            s = obj.SensorModel.MountingAngles;
        end
        
        function set.MountingAngles(obj, angles)
            obj.SensorModel.MountingAngles = angles;
        end

        function s = get.MountingLocation(obj)
            s = obj.SensorModel.MountingLocation;
        end
        
        function set.MountingLocation(obj, location)
            obj.SensorModel.MountingLocation = location;
        end

        function s = get.AzimuthLimits(obj)
            s = obj.SensorModel.MountingLocation;
        end
        
        function set.AzimuthLimits(obj, limits)
            obj.SensorModel.MountingLocation = limits;
        end
    end

    methods
        function obj = uavTOF(sensorModel)
            %uavIMU            
            obj@uav.SensorAdaptor(sensorModel);

        end
        
        function setup(~, ~, ~)
            %setup the sensor
        end
        
        function [acc, gyro] = read(obj, scene, platform, sensor, t)
            %read the accelerometer and gyroscope readings
            motion = uav.SensorAdaptor.getMotion(scene, platform, sensor, t);
            tformPR2R = scene.TransformTree.getTransform(obj.SensorModel.ReferenceFrame, platform.ReferenceFrame, t);
            rotmPR2R = tform2rotm(tformPR2R);        
            
            % use imu sensor to gather readings
            [acc, gyro] = obj.SensorModel((rotmPR2R*motion(7:9)')', (rotmPR2R*motion(14:16)')', ...
                quaternion(rotm2quat(rotmPR2R*(quat2rotm(motion(10:13))))));
        end

        
        function out = getEmptyOutputs(~)
            %getEmptyOutputs
            out = {nan(1,3), nan(1,3)};
        end
        
        function reset(obj)
            %reset the sensor
            obj.SensorModel.reset();
        end
    end
end

