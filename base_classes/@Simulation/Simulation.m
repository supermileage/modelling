classdef Simulation
    %SIMULATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        assumps AssumptionSet;
    end
    
    methods
        function obj = Simulation(assumps)
            %SIMULATION Construct an instance of this class
            %   Detailed explanation goes here
            obj.assumps = assumps;
        end
        
        function res = run(obj)
            %RUN  Runs the Simulation object
            %   Detailed explanation goes here
            
            % Extract Component and User from AssumptionSet
            comp = obj.assumps.component;
            user = obj.assumps.user;
            
            % Define standalone model name
            modelName = 'standaloneSim';
            
            % Create a standalone system for the simulation
            new_system(modelName);
            
            % Add component block
            add_block([comp.libraryName, '/', comp.name], ...
                      [modelName, '/', comp.name]);
            
            % Set inputs for the system
                  
            % Add inputs
            % Connect inputs to component block
            
        end
    end
    
    methods (Access = private)
        
    end
end

