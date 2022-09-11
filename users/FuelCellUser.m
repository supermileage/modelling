classdef FuelCellUser < User
    %FUELCELLUSER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        hydrogen = struct(...
            'temperature', [], ...
            'pressure', [], ...
            'massFlow', []);
        air = struct(...
            'temperature', [], ...
            'pressure', [], ...
            'massFlow', []);
    end
    
    methods
        function obj = FuelCellUser()
            %FUELCELLUSER Construct an instance of this class
            %   Detailed explanation goes here
            obj@User('user');
        end
    end
end

