classdef MotorUser < User
    %MOTORUSER  Summary of this class goes here
    %   Detailed explanation goes here
    %
    %======================================================================
    %   Author: Eric Bokenfohr
    %   Date: 2023-02-11
    %======================================================================
    
    properties
        v_abc
        motorSpeed
    end
    
    methods
        function obj = MotorUser()
            %MOTORUSER Construct an instance of this class
            %   Detailed explanation goes here
            obj@User('user');
        end
    end
end

