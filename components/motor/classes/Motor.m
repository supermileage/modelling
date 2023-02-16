classdef Motor < Component
    %MOTOR  Summary of this class goes here
    %   Detailed explanation goes here
    %
    %======================================================================
    %   Author: Eric Bokenfohr
    %   Date: 2023-02-11
    %======================================================================
    
    properties
        motorName               % The name of the motor
        poles                   % Number of poles
        R_s                     % Stator winding resistance [Ohms]
        lambda_PM               % PM flux linkage [Wb-turns or V-s]
        L_ss                    % Winding inductance [H]
        tau_s                   % Motor time constant [s]
    end
    
    methods
        function obj = Motor(blockChoice)
            %UNTITLED4 Construct an instance of this class
            %   Detailed explanation goes here
            
            % Call parent constructor
            obj@Component('motor', 'motorLibrary');
            
            % Set library block choice
            obj.blockChoice = blockChoice;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

