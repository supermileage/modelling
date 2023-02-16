function chassis = chassis_instance_FCP_SEMA2022()
%CHASSIS_INSTANCE_FCP_SEMA2022  Create an instance of the 2022 FCP chassis
%   This function creates an instance of the FCP chassis based on SEMA 2022
%   metrics, with the 'Blues' as the wheels

    chassis = Chassis('simple');
    chassis.wheel = wheel_instance_MichelinBlue();
    
    chassis.vehicleMass = 35;       % [kg] From SEMA 2022, without H2 tank
    chassis.numWheels = 3;

end

