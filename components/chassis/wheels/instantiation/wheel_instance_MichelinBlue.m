function wheel = wheel_instance_MichelinBlue()
%WHEEL_INSTANCE_MICHELINBLUE  Create an instance of the Michelin Blue wheel
%   This function creates an instance of the Wheel class that represents
%   the Michelin 44-406 tire, also referred to as 'Blues'.
%
%==========================================================================
%   Author: Eric Bokenfohr
%   Date: 2023-02-16
%==========================================================================

    wheel = Wheel('simple');
    
    wheel.C_rr = 0.0024;    % [-] At 5 bar and 40km/h, from The World's Most Fuel Efficient Vehicle
    wheel.radius = 0.24;    % [m] Measured on 2023-02-16 using a tape

end

