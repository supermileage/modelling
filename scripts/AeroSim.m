%% Aero Simulation
%   Perform a simple simulation of aerodynamic drag
%   This script is more-so for checking that the model architecture is
%   working as intended

% Define the assumptions
aero = aero_assump_2006Prototype;

% Define the user
user = AeroUser();
user.startTime = 0;
user.stopTime = 10;
user.timeProfile = [0 : 0.1 : 10];
user.vehicleSpeed = 7 * user.timeProfile;
user.crosswind = 0 * user.timeProfile;

% Create the assumption set
assump = AssumptionSet(aero, user);

% Create and run the simulation
aeroSim = Simulation(assump);
res = aeroSim.run();