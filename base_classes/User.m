classdef User
    %USER  Top-level User class definition
    %   Detailed explanation goes here
    %
    %   PROPERTIES
    %       name
    %       startTime
    %       stopTime
    %       timeProfile
    %
    %   METHODS
    %       constructor
    %
    %======================================================================
    %   Author: Eric Bokenfohr
    %   Date: 2023-02-01
    %======================================================================
    
    % Public properties
    properties
        name;
        startTime;
        stopTime;
        timeProfile;
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

