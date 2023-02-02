function aero = aero_assump_2006Prototype()
%AERO_ASSUMP_2006PROTOTYPE  Intantiation function for the 2006 Prototype
%shell
%   Detailed explanation goes here
%
%==========================================================================
%   Author: Eric Bokenfohr
%   Date: 2023-02-01
%==========================================================================
    
    % Create an instance of the Aero object
    aero = Aero('simple');
    
    % Define properties
    aero.density = 1.225;       % [kg/m^3]
    aero.frontalArea = 0.313;   % [m^2] From 2006 design report MATLAB code
    aero.wettedArea = NaN;      % Not currently used
    aero.Cd = 0.17;             % From 2006 design report MATLAB code
    aero.Cl = NaN;              % Not currently used
    
end

