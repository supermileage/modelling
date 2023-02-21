function fc = fuelCell_instance_19cells()
%FUELCELL_ASSUMP_19CELLS  Create instance of a 19-cell fuel cell stack
%   Detailed explanation goes here
%
%==========================================================================
%   Author: Eric Bokenfohr
%   Date: 2023-02-12
%==========================================================================

    fc = FuelCell('simple');

    % Denfine properties
    fc.cellCount = 19;
    fc.activeArea = 60;                     % [cm^2]
    fc.crossoverCurrentDensity = 0.0025;    % [A cm^-2]

end

