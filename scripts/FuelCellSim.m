%% Fuel Cell Simulation
%   Perform a simulation of a fuel cell.

% Define component and user
fuelCell = fuelCell_assump_19cells();

% Define the user
user = FuelCellUser();
user.startTime = 0;
user.stopTime = 10;
user.timeProfile = [0 : 0.1 : 10];

user.hydrogen.temperature = 0*user.timeProfile + 25;    % [degC]
user.hydrogen.pressure = 0*user.timeProfile + 200;      % [kPa]
user.hydrogen.massFlow = 0*user.timeProfile + 3.7;

user.air.temperature = 0*user.timeProfile + 16;
user.air.pressure = 0*user.timeProfile + 100;
user.air.massFlow = 0*user.timeProfile + 7;

% Create assumption set
assump = AssumptionSet(fuelCell, user);

% Create and run simulation
fcSim = Simulation(assump);
res = fcSim.run();