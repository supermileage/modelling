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
    %   Date: 2023-02-02
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
            
            % Define standalone model name
            modelName = 'standaloneSim';
            
            % Create a standalone system for the simulation
            new_system(modelName);
            
            % Add component block
            add_block([comp.libraryName, '/', comp.name], ...
                      [modelName, '/', comp.name]);
            
            % Set inputs for the system
            % Inputs come from the User object
            parentProperties = properties('User');
            inputNames = properties(user);
            
            % Remove any inputs that come from the User parent class (since
            % they aren't physical model inputs)
            ii = 1;
            while ii <= length(inputNames)
                if any(strcmp(inputNames{ii}, parentProperties))
                    inputNames(ii) = [];
                else
                    ii = ii + 1;
                end
            end
            
            numInputsProvided = length(inputNames);
                  
            % Add input LUTs
            add_block('simulink/Sources/Clock', [modelName, '/Clock']);
            PH_clock = get_param([modelName, '/Clock'], 'PortHandles');
            PH_inputLUT = cell(numInputsProvided, 1);
            
            for ii = 1 : numInputsProvided
                
                inputBlockPath = [modelName, '/', inputNames{ii}];
                
                % Add LUT and set table data/breakpoints
                add_block('simulink/Lookup Tables/1-D Lookup Table', ...
                          inputBlockPath);
                set_param(inputBlockPath, ...
                          'Table', [user.name, '.', inputNames{ii}], ...
                          'BreakpointsForDimension1', [user.name, '.timeProfile']);
                % Get the port handles of the LUT
                PH_inputLUT = get_param(inputBlockPath, 'PortHandles');
                
                % Connect the clock to the LUT
                add_line(modelName, PH_clock.Outport, PH_inputLUT.Inport);
                
            end
            
            % Get the names of the component block inports
            compInports = find_system([modelName,'/',comp.name,'/',comp.blockChoice], 'BlockType', 'Inport');
            compInportNames = get_param(compInports, 'Name');
            % Get component block port handles
            PH_comp = get_param([modelName,'/',comp.name], 'PortHandles');
            
            % Check that the number of inport names and handles matches up
            if length(compInportNames) ~= length(PH_comp.Inport)
                error('Mismatch between number of component block inport names and handles.');
            end
            
            % Connect inputs to component block
            for ii = 1 : length(compInportNames)
                try
                    PH_inputLUT = get_param([modelName,'/',compInportNames{ii}], 'PortHandles');
                    add_line(modelName, PH_inputLUT.Outport, PH_comp.Inport(ii));
                catch
                    warning(['The input ', compInportNames{ii}, ' was not provided.']);
                end
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
            if out.logsout.numElements > 0
                for ii = 1 : out.logsout.numElements
                    logName = out.logsout{ii}.Name;
                    logData = out.logsout{ii}.Values.Data;
                    res.logs.(logName) = logData;
                end
            end
        end
    end
    
    methods (Access = private)
        
    end
end

