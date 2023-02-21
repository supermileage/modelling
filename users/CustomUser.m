classdef CustomUser < User
    %CUSTOMUSER  Definition of User class for custom models
    %   Detailed explanation goes here
    
    properties
        inputs = struct()
    end
    
    methods
        function obj = CustomUser()
            %CUSTOMUSER Construct an instance of this class
            %   Detailed explanation goes here
            obj@User('user');
        end
    end
end

