classdef AeroUser < User
    %AEROUSER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        vehicleSpeed;
        crosswind;
        
    end
    
    methods
        function obj = AeroUser()
            %AEROUSER Construct an instance of this class
            %   Detailed explanation goes here
            obj@User('user');
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

