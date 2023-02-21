classdef Wheel < Component
    %WHEELS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        C_rr            % Tire rolling resistance coeff. [-]
        radius          % Wheel radius [m]
    end
    
    methods
        function obj = Wheel(blockChoice)
            %WHEELS Construct an instance of this class
            %   Detailed explanation goes here
            obj@Component('wheel', 'wheelLibrary');
            obj.blockChoice = blockChoice;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

