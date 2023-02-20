customModel = CustomModel('FCPDrag');
chassis = chassis_instance_FCP_SEMA2022(50);
aero = aero_assump_2006Prototype;
customModel.components = {chassis ; aero};
clear chassis aero

user = CustomUser();
user.startTime = 0;
user.stopTime = 15;
user.timeProfile = [user.startTime : 0.1 : user.stopTime]';

user.inputs.vehicleSpeed = (26.6 / 3.6) * (1 - exp(-1*user.timeProfile));

assump = AssumptionSet(customModel, user);

customSim = Simulation(assump);
res = customSim.run();