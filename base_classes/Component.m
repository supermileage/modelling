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
        
        function subComponents = getSubComponents(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            % Find subcomponents
            compProperties = properties(obj);
            subComponents = cell(length(compProperties), 1);
            numSubs = 0;

            for ii = 1 : length(compProperties)
                % Fetch the superclasses of the property
                supClasses = superclasses(class(obj.(compProperties{ii})));

                % If Component is a superclass, then its a subcomponent
                % --> Save the subcomponent obj to the cell array
                if any(strcmp('Component', supClasses))
                    numSubs = numSubs + 1;
                    subComponents{numSubs} = obj.(compProperties{ii});
                end
            end
            subComponents = subComponents(1:numSubs); % Trim excess

            % Recursively find the subcomponents of each subcomponent
            for ii = 1 : numSubs
                
                % Find the subcomponents (i.e. the sub-subcomponents)
                subSubComponents = subComponents{ii}.getSubComponents();

                % Add sub-subcomponents to list
                subComponents = [subComponents ; subSubComponents];

            end

        end
        
        function success = initializeSubComponents(obj)
            %INITIALIZESUBCOMPONENTS  Initialize all subcomponents of the
            %object
            
            subComponents = obj.getSubComponents();
            
            % Initialize all the subcomponents
            
        end
    end
end

