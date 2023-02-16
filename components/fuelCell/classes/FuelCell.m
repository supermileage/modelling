classdef FuelCell < Component
    %FUELCELL  Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        cellCount                   % Number of cells in the stack
        activeArea                  % Active area of each cell
        crossoverCurrentDensity     % The crossover current density
    end
    
    methods
        function obj = FuelCell(blockChoice)
            %FUELCELL Construct an instance of this class
            %   Detailed explanation goes here
            obj@Component('fuelCell', 'fuelCellLibrary');
            
            % Set library block choice
            obj.blockChoice = blockChoice;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

