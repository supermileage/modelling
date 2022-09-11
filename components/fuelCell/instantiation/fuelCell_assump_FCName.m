function fc = fuelCell_assump_FCName()
%FUELCELL_ASSUMP_FCNAME Summary of this function goes here
%   Detailed explanation goes here

fc = FuelCell();
% Define any subcomponents, e.g.
% fc.Electrical = fuelCellElectrical_assump_FCElecName();

% Define block choice?
fc.blockChoice = 'baseModel';
end

