function motor = motor_assump_129H169T()
%MOTOR_ASSUMP_129H169T  Create an instance of the Koford 129H169T motor
%   This function creates an instance of the Motor class that defines the
%   Koford 129H169T motor at 48V using provided motor parameters. This
%   motor is the brushless motor used for the Battery Eletric Urban
%   vehicle.
%
%==========================================================================
%   Author: Eric Bokenfohr
%   Date: 2023-02-11
%==========================================================================

    motor = Motor('steadyState');
    
    % Need to back-calculate the motor parameters from Koford's provided
    % numbers
    Kt = 7.99 * 0.00706;    % [Nm/A] - converting from [oz-in/A]
    velConst = 169 * convert('rpm','rad/s'); % [rad/s / V]
    
    % Define properties
    motor.motorName = '129H169T_48V';
    motor.poles = 10;                           % [-] From datasheet
    motor.R_s = 0.053;                          % [Ohms] From datasheet
    
    % Lambda calculation using Kt
    motor.lambda_PM = (2/3) * 2 * Kt / motor.poles;     % [Wb-turns or V-s]
    % Lambda calculation using the velocity constant
    %motor.lambda_PM = 1 / velConst;             % [V-s or Wb-turns]
    
    % Datasheet says winding inductance is 
    motor.L_ss = 0.21 / 1000;                   % [H] From datasheet
    motor.tau_s = motor.L_ss / motor.R_s;       % [s]
end

