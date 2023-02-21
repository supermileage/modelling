classdef Drivetrain < Component
    %DRIVETRAIN  Summary of this class goes here
    %   Detailed explanation goes here
    %
    %======================================================================
    %   Author: Eric Bokenfohr
    %   Date: 2023-02-20
    %======================================================================
    
    properties
        gearRatio               % The drivetrain gear ratio [-]
        efficiency              % The drivetrain energy efficiency [-]
    end
    
    methods
        function obj = Drivetrain(blockChoice)
            %DRIVETRAIN  Construct an instance of this class
            %   The constructor calles the Component superclass
            %   constructor and assigns the block choice.
            obj@Component('drivetrain', 'drivetrainLibrary');
            obj.blockChoice = blockChoice;
        end
    end
end

