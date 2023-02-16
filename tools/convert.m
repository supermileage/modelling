function conversion = convert(unit1, unit2)
%CONVERT  Convert from one set of units to another
%   CONVERT(UNIT1, UNIT2) returns the ratio to convert from UNIT1 to UNIT2.
%
%==========================================================================
%   Author: Eric Bokenfohr
%   Date: 2023-02-01
%==========================================================================

    %% Unit Initialization
    
    % unitArray is the cell array that stores all information on supported
    % units
    %   Col 1: unit name
    %   Col 2: unit value (in relation to base unit)
    %   Col 3: unit type (length, time, speed, etc)
    unitArray = {...
        
    % Time units
    's', 1, 'time';
    'min', 1/60, 'time';
    'hr', 1/3600, 'time';
    
    % Length units
    'm', 1, 'length';
    'cm', 100, 'length';
    'mm', 1000, 'length';
    'km', 1/1000, 'length';
    'in', 1/0.0254, 'length';
    'ft', 1/0.0254/12, 'length';
    
    % Speed units
    'm/s', 1, 'speed';
    
    % Rotation units
    'rad/s', 1, 'rotation';
    'rpm', 60/(2*pi), 'rotation';
    
    % Force units
    'N', 1, 'force';
    'kN', 1/1000, 'force';
    'oz', 3.597, 'force';
    
    };

    %% Ratio Calculation
    
    if nargin == 0      % No inputs provided; display the supported units
        
        % Get the unit typtes
        unitTypes = unique(unitArray(:, 3));
        
        for ii = 1:length(unitTypes)
            
            typeStr = upper(unitTypes{ii});
            supportedUnits = unitArray(strcmpi(typeStr, unitArray(:, 3)), 1);
            
            disp(['=====', typeStr, '=====']);
            disp(supportedUnits);
            
        end
        
    elseif nargin == 1      % One input provided; INVALID
        error('Only one unit passed to the function.');
    else
        
        % Find the indexes of the units
        index1 = find(strcmpi(unit1, unitArray(:,1)), 1);
        index2 = find(strcmpi(unit2, unitArray(:,1)), 1);
        
        % Return error if any indexes are empty (i.e. the units cound't be
        % found
        if isempty(index1) && isempty(index2)
            error([unit1, ' and ', unit2, ' not supported.']);
        elseif isempty(index1)
            error([unit1, ' not supported.']);
        elseif isempty(index2)
            error([unit2, ' not supported.']);
        end
        
        % Check that the units are the same type; if not, return an error
        if ~strcmpi(unitArray{index1, 3}, unitArray{index2, 3})
            error('Unit types do not match.');
        end
        
        % Unit validity has been confirmed at this point in the code (both
        % that the units are supported and that they are the same type) so
        % the conversion can be returned
        
        conversion = unitArray{index2, 2} / unitArray{index1, 2};
        
    end

end

