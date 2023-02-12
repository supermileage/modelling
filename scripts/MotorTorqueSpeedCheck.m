%% Motor Speed Check
%   Run a motor simulation to check that the estimated performance lines up
%   with empirical data

%% Empirical Data
% Motor: 129H169T @ 48V

motorSpeed_test = [6064;
                   6360;
                   6510;
                   6709;
                   6777;
                   6954;
                   7153;
                   7366;
                   7583;
                   7805;
                   8128;
                  ];        %[rpm]
              
motorTorque_test = [198.82;
                    173.55;
                    152.69;
                    134.46;
                    115.01;
                    95.34;
                    76.05;
                    56.61;
                    38.59;
                    20.98;
                    0.00;
                   ];       % [oz-in]
               
motorTorque_test = motorTorque_test * 0.00706;  % [Nm]
               
powerOut_test = [898.31;
                 816.83;
                 735.63;
                 663.36;
                 576.85;
                 490.72;
                 402.56;
                 308.61;
                 216.54;
                 121.20;
                 0.00;
                ];          % [Watts]
         
current_test = [22.00;
                20.00;
                18.00;
                16.00;
                14.00;
                12.00;
                10.00;
                8.00;
                6.00;
                4.00;
                1.33;
               ];           % [A]
        
%% Simulation

% Define component and user
motor = motor_assump_129H169T();

user = MotorUser();
user.startTime = 0;
user.stopTime = 33;
user.timeProfile = linspace(0, 33, length(motorSpeed_test) * 3)';

user.v_abc = 0*user.timeProfile + 48;
user.motorSpeed = zeros(length(user.timeProfile), 1);

for ii = 1 : length(motorSpeed_test)
    
    idx = [1, 2, 3] + 3*(ii-1);
    
    user.motorSpeed(idx) = ones(3,1) * motorSpeed_test(ii);
    
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

% powerIn [Watts]
powerIn_test = current_test * 48;
powerIn_sim = voltage_sim .* current_sim;

% powerOut [Watts]
powerOut_sim = motorSpeed_sim * convert('rpm','rad/s') .* motorTorque_sim;

% Efficiency
eff_test = powerOut_test ./ powerIn_test;
eff_sim = powerOut_sim ./ powerIn_sim;

%% Plots

figure;
tiledlayout(2,1);

nexttile();
hold on;

plot(motorSpeed_test, motorTorque_test, ...
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

plot(motorSpeed_test, eff_test, ...
     'DisplayName', 'Empirical Efficiency');
plot(motorSpeed_sim, eff_sim, ...
     'DisplayName', 'Simulation Efficiency');

title('Efficiency-Speed');
grid on;
xlabel('Speed [RPM]');
ylabel('Efficiency [-]');
legend;