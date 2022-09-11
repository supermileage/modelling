classdef Simulation
    %SIMULATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        assumps AssumptionSet;
    end
    
    methods
        function obj = Simulation(assumps)
            %SIMULATION Construct an instance of this class
            %   Detailed explanation goes here
            obj.assumps = assumps;
        end
        
        function res = run(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
    
    methods (Access = private)
        
    end
end

