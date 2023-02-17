customModel = CustomModel('FCPDrag');
chassis = chassis_instance_FCP_SEMA2022;
aero = aero_assump_2006Prototype;
customModel.components = {chassis ; aero};
clear chassis aero

user = CustomUser();
user.startTime = 0;
user.stopTime = 7;
user.timeProfile = [user.startTime : 0.1 : user.stopTime]';

user.inputs.vehicleSpeed = user.timeProfile * 26.6 / 3.6;

assump = AssumptionSet(customModel, user);

customSim = Simulation(assump);
res = customSim.run();