classdef Component
    %COMPONENT  Top-level Component class definition
    %   Detailed explanation goes here
    %
    %   PROPERTIES
    %       name: the name of the component
    %       libraryName: the name of the Simulink library for the component
    %       blockChoice: the block from the library to use
    %       initialized: a flag to indicate if the component is initialized
    %
    %   METHODS
    %       constructor
    %       getSubComponents
    %       initializeSubComponents
    %
    %======================================================================
    %   Author: Eric Bokenfohr
    %   Date: 2023-02-01
    %======================================================================
    
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

