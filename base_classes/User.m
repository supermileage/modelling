classdef User
    %USER Summary of this class goes here
    %   Detailed explanation goes here
    
    % Public properties
    properties
        name;
        startTime;
        stopTime;
        timeProfile;
        % Should timeStep factor in somewhere?
    end
    
    % Private properties
    properties (Access = private)
        
    end
    
    methods
        function obj = User(name)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = name;
        end
    end
end

