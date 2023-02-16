classdef CustomModel < Component
    %CUSTOMMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        modelName               % Name of the custom model to simulate
        components              % Cell array of components in the model
    end
    
    methods
        function obj = CustomModel(modelName)
            %CUSTOMMODEL Construct an instance of this class
            %   Detailed explanation goes here
            obj@Component('customModel', '');
            obj.blockChoice = '';
            obj.modelName = modelName;
        end
    end
end

