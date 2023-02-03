function fc = fuelCell_assump_19cells()
%FUELCELL_ASSUMP_19CELLS  Create instance of a 19-cell fuel cell stack
%   Detailed explanation goes here
%
%==========================================================================
%   Author: Eric Bokenfohr
%   Date: 2023-02-02
%==========================================================================

    fc = FuelCell('baseModel');

    % Denfine properties
    fc.cellCount = 19;

end

