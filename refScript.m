%% Reference Script
% This script contains code I've been playing around with to set up
% Simulations. I'm putting all the code here so that I can use it later
% when writing methods.

%% Adding Blocks (OLD)
add_block('fuelCellLibrary/fuelCell','standaloneSim/fuelCell');
% This works, sort of. But it adds a Variant Subsystem, not a Linked
% Subsystem
% So it turns out that the block is actually linked, it just isn't showing
% the little icon in the bottom left of the block
% Not a huge fan that it isn't officially a linked subsystem, but it will
% work for now

% Add sources
add_block('simulink/Sources/In Bus Element','standaloneSim/hydrogen');
add_block('simulink/Sources/In Bus Element','standaloneSim/air');

% Connect inputs
phHy = get_param('standaloneSim/vehicleSpeed','PortHandles');
phAir = get_param('standaloneSim/air','PortHandles');
phSys = get_param('standaloneSim/fuelCell','PortHandles');

add_line('standaloneSim', phHy.Outport(1), phSys.Inport(1));
add_line('standaloneSim', phAir.Outport(1), phSys.Inport(2));

%% Defining Inputs (OLD)
% Time Inputs
user.startTime = 0;
user.stopTime = 13;
user.timeStep = 0.1;
user.timeProfile = [0 : user.timeStep : user.stopTime]';

% Hydrogen
user.hydrogen.temperature = 30 + (user.timeProfile .* 0);
user.hydrogen.pressure = 2000 + (user.timeProfile .* 0);
user.hydrogen.massFlow = 2 + (user.timeProfile .* 0);

% Air
user.air.temperature = 20 + (user.timeProfile .* 0);
user.air.pressure = 1000 + (user.timeProfile .* 0);
user.air.massFlow = 1.2 + (user.timeProfile .* 0);

% Set the External Inputs for the system
set_param('standaloneSim','LoadExternalInput','on');
set_param('standaloneSim','ExternalInput', ...
    '[user.timeProfile, user.hydrogen, user.air]');
% Can't appear to pass structs, since they don't line up with the time
% values
% It also appears you need 'root level input ports', which is annoying...
% In Bus Elements might be a way to pass structs -- nevermind, they seem to
% work like bus selectors which isn't what I want

%% Set block choice
fuelCell.blockChoice = 'baseModel';
% Confirmed that this works

%% Instantiation, etc
% Define the assumptions
aero = aero_assump_2006Prototype;

% Define the user
user = AeroUser();
user.startTime = 0;
user.stopTime = 10;
user.timeProfile = [0 : 0.1 : 10];
user.vehicleSpeed = 7 * user.timeProfile;
user.crosswind = 0 * user.timeProfile;

%% Simulation Object Stuff
new_system('standaloneSim');
open_system('standaloneSim');

modelName = 'standaloneSim';
libraryName = aero.libraryName;
compName = aero.name;
blockChoice = aero.blockChoice;

add_block([libraryName, '/', compName], [modelName, '/', compName]);

% Input LUTs
add_block('simulink/Lookup Tables/1-D Lookup Table', 'standaloneSim/vehicleSpeed');
set_param('standaloneSim/vehicleSpeed', ...
          'Table', 'user.vehicleSpeed', ...
          'BreakpointsForDimension1', 'user.timeProfile');
add_block('simulink/Lookup Tables/1-D Lookup Table', 'standaloneSim/crosswind');
set_param('standaloneSim/crosswind', ...
          'Table', 'user.crosswind', ...
          'BreakpointsForDimension1', 'user.timeProfile');
add_block('simulink/Sources/Clock', 'standaloneSim/Clock');

% Connect clock to LUTs
phClock = get_param([modelName, '/Clock'], 'PortHandles');
phSpeed = get_param([modelName, '/vehicleSpeed'], 'PortHandles');
phCW = get_param([modelName, '/crosswind'], 'PortHandles');

add_line(modelName, phClock.Outport, phSpeed.Inport);
add_line(modelName, phClock.Outport, phCW.Inport);

% Get input names
% CAN'T SEEM TO GET THE INPORT NAMES OF A VARIANT SUBSYSTEM!!!! VERY MAD!!!
inports = find_system([modelName, '/', compName, '/', blockChoice], 'BlockType', 'Inport');
compHDL = get_param([modelName, '/', compName], 'PortHandles');
inNames = get_param(inports, 'Name');

% Should check inportHDL.Inport and inNames match lengths

% Connect LUT to inputs
for ii = 1:length(compHDL.Inport)
    try
        sourceHDL = get_param([modelName, '/', inNames{ii}], 'PortHandles');
        add_line(modelName, sourceHDL.Outport, compHDL.Inport(ii));
    catch
        warning(['The input ', inNames{ii}, ' was not found.']);
    end
end

%% Run the simulation
out = sim('standaloneSim', 'StartTime', 'user.startTime', 'StopTime', 'user.stopTime');

% Create the results structure
res.time = out.tout;
res.logs = struct;
for ii = 1 : out.logsout.numElements
    logName = out.logsout{ii}.Name;
    logData = out.logsout{ii}.Values.Data;
    res.logs.(logName) = logData;
end