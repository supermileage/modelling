function motor = motor_assump_60LH350T()
%MOTOR_ASSUMP_60LH350T  Create an instance of the Koford 60LH350T motor
%   This function creates an instance of the Motor class that defines the
%   Koford 60LH350T motor at 24V using provided motor parameters. This
%   motor is the brushless motor used for the Hydrogen Fuel Cell Prototype
%   vehicle, competition configuration.
%
%==========================================================================
%   Author: Eric Bokenfohr
%   Date: 2023-02-12
%==========================================================================

    motor = Motor('steadyState');
    
    % Need to back-calculate the motor parameters from Koford's provided
    % numbers
    velConst = 350 * convert('rpm','rad/s'); % [rad/s / V]
    
    % Define properties
    motor.motorName = '60LH350T';
    motor.poles = 4;                            % [-] From datasheet
    motor.R_s = 0.049;                          % [Ohms] From datasheet
    
    % Lambda calculation using the velocity constant
    motor.lambda_PM = 1 / (velConst*motor.poles/2);      % [V-s or Wb-turns]
    
    % Datasheet says winding inductance is 0.04 mH
    motor.L_ss = 0.04 / 1000;                   % [H]
    motor.tau_s = motor.L_ss / motor.R_s;       % [s]

end

