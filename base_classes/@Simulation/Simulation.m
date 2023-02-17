classdef Simulation
    %SIMULATION  Simulation class definition
    %   Detailed explanation goes here
    %
    %   PROPERTIES
    %       assumps
    %
    %   METHODS
    %       constructor
    %       run
    %
    %======================================================================
    %   Author: Eric Bokenfohr
    %   Date: 2023-02-16
    %======================================================================
    
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
            
            % Check if the Simulation is a custom model
            if isa(comp, 'CustomModel')
                
                modelName = comp.modelName;
                inputs = fieldnames(user.inputs);
                numInputs = length(inputs);
                
                externalInput = zeros(length(user.timeProfile), numInputs + 1);
                
                for ii = 1 : numInputs
                    
                    externalInput(:, ii+1) = user.inputs.(inputs{ii});
                    
                end
                
                load_system(modelName);
                
                set_param(modelName, 'LoadExternalInput', 'on', ...
                    'ExternalInput', 'externalInput');
                
                % Load in workspace variables
                mdlWS = get_param(modelName, 'modelworkspace');
                
                % Save each component in the model workspace
                for ii = 1 : length(comp.components)
                    
                    % Code here
                    mdlWS.assignin(comp.components{ii}.name, ...
                                   comp.components{ii});
                    
                end
                
            else
                modelName = configureComponentBlock(obj);
            end
            
            save_system(modelName);
            
            % Run the simulation
            try
                out = sim(modelName, ...
                          'StartTime', [user.name, '.startTime'], ...
                          'StopTime', [user.name, '.stopTime']);
            catch ME
                warning('The simulation failed.');
                warning(['IDENTIFIER: ', ME.identifier]);
                warning(['MESSAGE: ', ME.message]);
            end
            
            close_system(modelName);
                  
            % Post-processing
            res.time = out.tout;
            res.logs = struct;
            try
                for ii = 1 : out.logsout.numElements
                    logName = out.logsout{ii}.Name;
                    logData = out.logsout{ii}.Values.Data;
                    res.logs.(logName) = logData;
                end
            catch
                warning('No signals logged.');
            end
        end
    end
    
    methods (Access = private)
        modelName = configureComponentBlock(obj)
    end
end

