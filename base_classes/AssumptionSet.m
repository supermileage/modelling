classdef AssumptionSet
    %ASSUMPTIONSET  AssumptionSet class definition
    %   Detailed explanation goes here
    %
    %   PROPERTIES
    %       component
    %       user
    %
    %   METHODS
    %       constructor
    %       initialize
    %
    %======================================================================
    %   Author: Eric Bokenfohr
    %   Date: 2023-02-01
    %======================================================================
    
    properties
        component Component;
        user User;
    end
    
    methods
        function obj = AssumptionSet(comp, user)
            %UNTITLED3 Construct an instance of this class
            %   Detailed explanation goes here
            obj.component = comp;
            obj.user = user;
        end
        
        function success = initialize(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            success = obj.component.initialize();
        end
    end
end

