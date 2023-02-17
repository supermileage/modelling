function modelName = configureComponentBlock(obj)
%CONFIGURECOMPONENTBLOCK Summary of this function goes here
%   Detailed explanation goes here
%==========================================================================
%   Author: Eric Bokenfohr
%   Date: 2023-02-16
%==========================================================================

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

    % Set up each input in the model
    for ii = 1 : numInputsProvided

        if isstruct(user.(inputNames{ii}))

            inputBlockPath = [modelName, '/', inputNames{ii}];

            % Get the fields in the input structure
            inputFields = fieldnames(user.(inputNames{ii}));
            numFields = length(inputFields);

            % Add a bus creator, set the number of inputs, and get
            % port handles
            add_block('simulink/Signal Routing/Bus Creator', ...
                      inputBlockPath);
            set_param(inputBlockPath, ...
                      'Inputs', int2str(numFields));
            PH_bus = get_param(inputBlockPath, 'PortHandles');

            % Set up each field that is in the struct
            for jj = 1 : numFields

                inputBlockPath = [modelName, '/', inputNames{ii}, '_', inputFields{jj}];

                % Add LUT and set table data/breakpoints
                add_block('simulink/Lookup Tables/1-D Lookup Table', ...
                          inputBlockPath);
                set_param(inputBlockPath, ...
                          'Table', [user.name, '.', inputNames{ii}, '.', inputFields{jj}], ...
                          'BreakpointsForDimension1', [user.name, '.timeProfile']);
                % Get the port handles of the LUT
                PH_inputLUT = get_param(inputBlockPath, 'PortHandles');

                % Connect the clock to the LUT
                add_line(modelName, PH_clock.Outport, PH_inputLUT.Inport);

                % Connect the LUT to the bus creator
                add_line(modelName, PH_inputLUT.Outport, PH_bus.Inport(jj));

            end

        else

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
            PH_inputSource = get_param([modelName,'/',compInportNames{ii}], 'PortHandles');
            add_line(modelName, PH_inputSource.Outport, PH_comp.Inport(ii));
        catch
            warning(['The input ', compInportNames{ii}, ' was not provided.']);
        end
    end

end