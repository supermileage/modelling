classdef Aero < Component
    %AERO  The aerodynamics component(s) of the vehicle
    %   The AERO component covers all aerodynamic aspects of the vehicle;
    %   this implementation is only considering the single aerodynamic
    %   shell.
    %
    %   PROPERTIES
    %       density: the fluid density the vehicle is driving through
    %       frontalArea: the frontal area of the shell
    %       wettedArea: the wetted surface area of the shell
    %       Cd: the drag coefficient
    %       Cl: the lift coefficient
    %
    %   METHODS
    %       None
    %
    %======================================================================
    %   Author: Eric Bokenfohr
    %   Date: 2023-02-01
    %======================================================================
    
    % Public properties
    properties
        
        density             % Fluid density [kg/m^3]
        frontalArea         % Aero frontal area [m^2]
        wettedArea          % Aero wetted area [m^2]
        Cd                  % Drag coefficient [-]
        Cl                  % Lift coefficient [-]
        
    end
    
    methods
        function obj = Aero(blockChoice)
            %AERO  Construct an instance of the Aero component
            %   Class constructor
            obj@Component('aero', 'aeroLibrary');
            
            % Set library block choice
            obj.blockChoice = blockChoice;
        end
        
        function success = initialize(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            % aero initialization here
            
            % Initialize subcomponents if necessary
        end
    end
end

