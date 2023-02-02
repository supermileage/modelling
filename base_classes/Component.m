classdef Component
    %COMPONENT Top-level component class
    %   Detailed explanation goes here
    
    % Public properties
    properties
        
        name;
        libraryName;
        blockChoice;
        initialized = false;
        
    end
    
    % Private properties
    properties (Access = private)
        
    end
    
    methods
        function obj = Component(name,libraryName)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = name;
            obj.libraryName = libraryName;
        end
        
        function outputArg = getSubComponents(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            % Find subcomponents
            
            % Perform recursive getSubComponents
        end
        
        function success = initializeSubComponents(obj)
            %INITIALIZESUBCOMPONENTS  Initialize all subcomponents of the
            %object
            
            subComponents = obj.getSubComponents();
            
            % Initialize all the subcomponents
            
        end
    end
end

