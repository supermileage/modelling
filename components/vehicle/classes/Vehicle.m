classdef Vehicle < Component
    %VEHICLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        aero Aero               % Vehicle areo component
        chassis Chassis         % Vehicle chassis component
    end
    
    methods
        function obj = Vehicle(inputArg1,inputArg2)
            %VEHICLE Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

