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
                externalInput(:, 1) = user.timeProfile;
                
                for ii = 1 : numInputs
                    
                    externalInput(:, ii+1) = user.inputs.(inputs{ii});
                    
                end
                
                % Load the Simulink model
                load_system(modelName);
                
                % Assign the custom inputs as external inputs for the model
                set_param(modelName, 'LoadExternalInput', 'on', ...
                    'ExternalInput', 'externalInput');

                % Add externalInput to the model workspace
                mdlWS = get_param(modelName, 'modelworkspace');
                mdlWS.assignin('externalInput', externalInput);

                % Below is some code that, in theory, would use the
                % SimulationInput object to pass all the input information.
                % I would prefer to use this, but currently can't get it
                % working.
%                 simIn = Simulink.SimulationInput(modelName);
%                 simIn = setModelParameter(simIn, ...
%                                           'StartTime', num2str(user.startTime), ...
%                                           'StopTime', num2str(user.stopTime));
%                 simIn = setExternalInput(simIn, externalInput);
                
                % Save each component in the workspace
                for ii = 1 : length(comp.components)

                    currentComp = comp.components{ii};
                    
                    % Original plan was to save each component object in
                    % the model workspace using the line of code below:
                    %   mdlWS.assignin(comp.components{ii}.name, ...
                    %                  comp.components{ii});
                    %
                    % Unfortunately the variant subsystem can't use
                    % component.blockChoice to evaluate which variant to
                    % use. Until we can find a workaround, saving each
                    % component object in the base workspace works.
                    assignin('base', currentComp.name, ...
                             currentComp);

                    subComponents = currentComp.getSubComponents();

                    for jj = 1 : length(subComponents)
                        
                        assignin('base', subComponents{jj}.name, ...
                                 subComponents{jj});
                        
                    end
                    
                end
                
            else
                modelName = configureComponentBlock(obj);
            end
            
            % Run the simulation
            try
                out = sim(modelName, ...
                          'StartTime', [user.name, '.startTime'], ...
                          'StopTime', [user.name, '.stopTime']);
%                 out = sim(modelName, simIn);
                close_system(modelName, 0);
            catch ME
                warning('The simulation failed.');
                warning(['IDENTIFIER: ', ME.identifier]);
                warning(['MESSAGE: ', ME.message]);

                save_system(modelName);
                close_system(modelName);
            end
                  
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

            res.outputs = struct;
            try
                for ii = 1 : out.yout.numElements
                    outputName = out.yout{ii}.Name;
                    outputData = out.yout{ii}.Values.Data;
                    res.outputs.(outputName) = outputData;
                end
            catch
                warning('No model outputs recorded.');
            end
        end
    end
    
    methods (Access = private)
        modelName = configureComponentBlock(obj)
    end
end

