classdef Chassis < Component
    %CHASSIS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        wheel Wheel
        
        vehicleMass     % Mass of the vehicle [kg]
        driverMass      % Mass of the driver [kg]
        numWheels       % The number of wheels [-]
    end
    
    methods
        function obj = Chassis(blockChoice)
            %CHASSIS Construct an instance of this class
            %   Detailed explanation goes here
            
            % Parent class constructor
            obj@Component('chassis', 'chassisLibrary');
            
            obj.blockChoice = blockChoice;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

