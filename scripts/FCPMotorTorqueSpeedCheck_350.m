%% FCP 350 Motor Speed Check
%   Run a motor simulation to check that the estimated performance lines up
%   with empirical data for the FCP 350-winding motor

%% Empirical Data
% Motor: 60LH350T @ 24V

test = load('motor_data_60LH350T.mat');
        
%% Simulation

% Define component and user
motor = motor_assump_60LH350T();

user = MotorUser();
user.startTime = 0;
user.stopTime = 3 * 19;
user.timeProfile = linspace(user.startTime, user.stopTime, length(test.motorSpeed) * 3)';

user.v_abc = 0*user.timeProfile + 24;
user.motorSpeed = zeros(length(user.timeProfile), 1);

for ii = 1 : length(test.motorSpeed)
    
    idx = [1, 2, 3] + 3*(ii-1);
    
    user.motorSpeed(idx) = ones(3,1) * test.motorSpeed(ii);
    
end

% Create assumption set
assump = AssumptionSet(motor, user);

% Create and run simulation
motorSim = Simulation(assump);
res = motorSim.run();

%% Extra Calculations

% Motor speed [RPM]
motorSpeed_sim = res.logs.motorSpeed;

% Motor torque [Nm]
motorTorque_sim = res.logs.motorTorque;

% Voltage
voltage_sim = res.logs.phaseVoltage_peak;

% Current
current_sim = res.logs.phaseCurrent_peak;
current_sim = current_sim + 4;

% powerIn [Watts]
test.powerIn = test.current * 24;
powerIn_sim = voltage_sim .* current_sim;

% powerOut [Watts]
powerOut_sim = motorSpeed_sim * convert('rpm','rad/s') .* motorTorque_sim;

% Efficiency
test.eff = test.powerOut ./ test.powerIn;
eff_sim = powerOut_sim ./ powerIn_sim;

%% Plots

figure;
tiledlayout(3,1);

nexttile();
hold on;

plot(test.motorSpeed, test.motorTorque, ...
     'DisplayName', 'Empirical Torque');
plot(motorSpeed_sim, motorTorque_sim, ...
     'DisplayName', 'Simulation Torque');

title('Torque-Speed');
grid on;
xlabel('Speed [RPM]');
ylabel('Torque [Nm]');
legend;

nexttile();
hold on;

plot(test.motorSpeed, test.current, ...
     'DisplayName', 'Empirical Current');
plot(motorSpeed_sim, current_sim, ...
     'DisplayName', 'Simulation Current');
 
title('Current-Speed');
grid on;
xlabel('Speed [RPM]');
ylabel('Current [A]');
legend;
 
nexttile();
hold on;

plot(test.motorSpeed, test.eff, ...
     'DisplayName', 'Empirical Efficiency');
plot(motorSpeed_sim, eff_sim, ...
     'DisplayName', 'Simulation Efficiency');

title('Efficiency-Speed');
grid on;
xlabel('Speed [RPM]');
ylabel('Efficiency [-]');
legend;

figure;
tiledlayout(2,1);

nexttile();
hold on;

plot(test.motorSpeed, test.powerIn, ...
     'DisplayName', 'Empirical Input Power');
plot(motorSpeed_sim, powerIn_sim, ...
     'DisplayName', 'Simulation Input Power');

title('Input Power-Speed');
grid on;
xlabel('Speed [RPM]');
ylabel('Input Power [W]');
legend;

nexttile();
hold on;

plot(test.motorSpeed, test.powerOut, ...
     'DisplayName', 'Empirical Output Power');
plot(motorSpeed_sim, powerOut_sim, ...
     'DisplayName', 'Simulation Output Power');

title('Output Power-Speed');
grid on;
xlabel('Speed [RPM]');
ylabel('Output Power [W]');
legend;