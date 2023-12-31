sfnew DriveControlComponent;
ch = find(sfroot,"-isa","Stateflow.Chart");
%add Variables
distanceLimit =  Stateflow.Data(ch);
distanceLimit.name =  "distanceLimit";
distanceLimit.DataType = "int32";
distanceLimit.Scope = "Local";
desiredVelocity =  Stateflow.Data(ch);
desiredVelocity.name =  "desiredVelocity";
desiredVelocity.DataType = "int32";
desiredVelocity.Scope = "Local";
slowVelocity =  Stateflow.Data(ch);
slowVelocity.name =  "slowVelocity";
slowVelocity.DataType = "double";
slowVelocity.Scope = "Local";
laneDistance =  Stateflow.Data(ch);
laneDistance.name =  "laneDistance";
laneDistance.DataType = "int32";
laneDistance.Scope = "Local";
DriveControl_main = Stateflow.State(ch);
DriveControl_main.Name = "DriveControl_main";
DriveControl_main.Position = [10 10 1000 800];
DriveControl_main.Decomposition = "PARALLEL_AND"; 
driveControlPort = Stateflow.State(DriveControl_main);
driveControlPort.Name = "driveControlPort";
% x, y, lenghth, width
y = (1-1) *200 + (1-1) * 40 + 30;
y = 40
driveControlPort.Position =  [80 y 900 200];

AutonomousDriving = Stateflow.State(driveControlPort);
AutonomousDriving.Name = "AutonomousDriving";
x =  100
y =  80
AutonomousDriving.Position = [x y 90 60];
%add self transition
Self_Transition = Stateflow.Transition(driveControlPort);
Self_Transition.Destination = AutonomousDriving;
Self_Transition.DestinationOClock = 0;
Self_Transition.SourceEndpoint = Self_Transition.DestinationEndpoint-[0 30];
Self_Transition.Midpoint = Self_Transition.DestinationEndpoint-[0 15];
WaitForPermission = Stateflow.State(driveControlPort);
WaitForPermission.Name = "WaitForPermission";
x =  650
y =  80
WaitForPermission.Position = [x y 90 60];
Overtaking = Stateflow.State(driveControlPort);
Overtaking.Name = "Overtaking";
x =  300
y =  120
Overtaking.Position = [x y 90 60];
Transition_ = Stateflow.Transition(driveControlPort)
Transition_.Source = WaitForPermission;
Transition_.Destination = Overtaking;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "";
Transition_.LabelString = Transition_.LabelString + "driveControl_recv" + '==' + "GUARD_EVENT_4";
Transition_.LabelString = Transition_.LabelString + "send(startOvertaking)";
Transition_ = Stateflow.Transition(driveControlPort)
Transition_.Source = AutonomousDriving;
Transition_.Destination = WaitForPermission;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "";
Transition_.LabelString = Transition_.LabelString + "driveControl_send" + '==' + "ACTION_SEND_1";
Transition_.LabelString = Transition_.LabelString + "send()";
Transition_ = Stateflow.Transition(driveControlPort)
Transition_.Destination = AutonomousDriving;
Transition_.Source = WaitForPermission;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "driveControl_recv" + '==' + "GUARD_EVENT_2";
Transition_ = Stateflow.Transition(driveControlPort)
Transition_.Destination = AutonomousDriving;
Transition_.Source = Overtaking;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "driveControl_send" + '==' + "ACTION_SEND_7";
Transition_.LabelString = Transition_.LabelString + "overtakingSuccessful";


%Ports
driveControl_recv =  Stateflow.Data(ch);
driveControl_recv.name =  "driveControl_recv";
driveControl_recv.Scope = "Input";
driveControl_send =  Stateflow.Data(ch);
driveControl_send.name =  "driveControl_send";
driveControl_send.Scope = "Output";
driving = Stateflow.State(DriveControl_main);
driving.Name = "driving";
% x, y, lenghth, width
y = (2-1) *200 + (2-1) * 40 + 30;
driving.Position =  [80 y 900 200];

FollowMainLane = Stateflow.State(driving);
FollowMainLane.Name = "FollowMainLane";
x =  100
y =  140 + 200
FollowMainLane.Position = [x y 90 60];
%add self transition
Self_Transition = Stateflow.Transition(driving);
Self_Transition.Destination = FollowMainLane;
Self_Transition.DestinationOClock = 0;
Self_Transition.SourceEndpoint = Self_Transition.DestinationEndpoint-[0 30];
Self_Transition.Midpoint = Self_Transition.DestinationEndpoint-[0 15];
PassSlowerVehicle = Stateflow.State(driving);
PassSlowerVehicle.Name = "PassSlowerVehicle";
x =  650
y =  120 +200
PassSlowerVehicle.Position = [x y 90 60];
CompleteOvertaking = Stateflow.State(driving);
CompleteOvertaking.Name = "CompleteOvertaking";
x =  300
y =  200 + 200
CompleteOvertaking.Position = [x y 90 60];
Transition_ = Stateflow.Transition(driving)
Transition_.Source = FollowMainLane;
Transition_.Destination = PassSlowerVehicle;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "";
Transition_.LabelString = Transition_.LabelString + "startOvertaking";
Transition_ = Stateflow.Transition(driving)
Transition_.Destination = FollowMainLane;
Transition_.Source = CompleteOvertaking;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "";
Transition_.LabelString = Transition_.LabelString + "send(overtakingSuccessful)";
Transition_ = Stateflow.Transition(driving)
Transition_.Source = PassSlowerVehicle;
Transition_.Destination = CompleteOvertaking;
Transition_.LabelString = "";


%Ports



sfsave;
