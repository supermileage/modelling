function dt = drivetrain_instance_FCPChainDrive()
%DRIVETRAIN_INSTANCE_FCPCHAINDRIVE  Create an instance of the FCP chain
%drive
%   Detailed explanation goes here
%
%==========================================================================
%   Author: Eric Bokenfohr
%   Date: 2023-02-20
%==========================================================================
    
    dt = Drivetrain('simple');

    dt.gearRatio = 12.25;           % [-] FCP gear ratio - 12.25 : 1
    dt.efficiency = 0.90;           % [-] Estimated efficiency of chain drive

end

