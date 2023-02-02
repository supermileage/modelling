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
        
        density
        frontalArea;
        wettedArea;
        Cd;
        Cl;
        
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

