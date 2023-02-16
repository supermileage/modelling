%% Motor Simulation
%   Performance a simple motor simulation
%
%==========================================================================
%   Author: Eric Bokenfohr
%   Date: 2023-02-11
%==========================================================================

% Define component and user
motor = motor_assump_129H169T();

user = MotorUser();
user.startTime = 0;
user.stopTime = 2;
user.timeProfile = [0 : 0.1 : 2];

user.v_abc = 0*user.timeProfile + 48;
user.motorSpeed = 0*user.timeProfile + 6954;

% Create assumption set
assump = AssumptionSet(motor, user);

% Create and run simulation
motorSim = Simulation(assump);
res = motorSim.run();