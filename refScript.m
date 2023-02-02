%% Reference Script
% This script contains code I've been playing around with to set up
% Simulations. I'm putting all the code here so that I can use it later
% when writing methods.

%% Adding Blocks
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
phHy = get_param('standaloneSim/hydrogen','PortHandles');
phAir = get_param('standaloneSim/air','PortHandles');
phSys = get_param('standaloneSim/fuelCell','PortHandles');

add_line('standaloneSim', phHy.Outport(1), phSys.Inport(1));
add_line('standaloneSim', phAir.Outport(1), phSys.Inport(2));

%% Defining Inputs
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

%% Run the simulation
out = sim('standaloneSim');