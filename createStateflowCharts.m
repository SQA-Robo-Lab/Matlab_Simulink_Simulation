function ch = createStateflowCharts
%rt = sfroot;
%ch = find(sfroot,"-isa","Stateflow.State",Name="On")
%prev_machines = find(rt,"-isa","Stateflow.Machine");

%new_system('driveControl_StateflowChart')
sfnew 'driveControl_StateflowChart8';

ch = find(sfroot,"-isa","Stateflow.Chart");
ch.Name = "driveControl_Chart";


chart2 = Stateflow.State(ch);
chart2.Name = "chart";
chart2.Position = [10 10 1000 800];
chart2.Decomposition = "PARALLEL_AND"; 

chartRegion = Stateflow.State(chart2);
chartRegion.Name = "chartRegion";
chartRegion.Position = [20 30 950 700];


driveControlCom = Stateflow.State(chartRegion);
%setName from MUML model
driveControlCom.Name = "DriveControlComponent";
driveControlCom.Position = [30 80 900 600];
driveControlCom.Decomposition = "PARALLEL_AND"; 

driveControlport = Stateflow.State(driveControlCom);
%setName from MUML model
driveControlport.Name = "driveControlPort";
driveControlport.Position = [50 110 850 200];

%Add 1 first 

driving = Stateflow.State(driveControlCom);
%setName from MUML model
driving.Name = "driving";
% x, y, lenghth, width
driving.Position = [50 410 850 200];

%Add States 
Idle = Stateflow.State(driveControlport);
Idle.Name = "Idle";
Idle.Position = [90 150 90 60];
WaitforCoordinator = Stateflow.State(driveControlport);
WaitforCoordinator.Name = "WaitforCoordinator";
WaitForOvertaking = Stateflow.State(driveControlport);
WaitForOvertaking.Name = "WaitForOvertaking";
WaitforCoordinator.Position = [280 150 90 60];
WaitForOvertaking.Position = [120 240 90 60];

%Add default Transistion
dtChart = Stateflow.Transition(ch);
dtChart.Destination = chart2;
dtChart.DestinationOClock = 0;
dtChart.SourceEndpoint = dtChart.DestinationEndpoint-[0 30];
dtChart.Midpoint = dtChart.DestinationEndpoint-[0 15];

dtaA_Dcomp = Stateflow.Transition(chartRegion);
dtaA_Dcomp.Destination = driveControlCom;
dtaA_Dcomp.DestinationOClock = 0;
dtaA_Dcomp.SourceEndpoint = dtaA_Dcomp.DestinationEndpoint-[0 30];
dtaA_Dcomp.Midpoint = dtaA_Dcomp.DestinationEndpoint-[0 15];

dtA = Stateflow.Transition(driveControlport);
dtA.Destination = Idle;
dtA.DestinationOClock = 0;
dtA.SourceEndpoint = dtA.DestinationEndpoint-[0 30];
dtA.Midpoint = dtA.DestinationEndpoint-[0 15];


%Add Input and Output
frontDistance = Stateflow.Data(ch);
frontDistance.Name = "frontDistance";
frontDistance.DataType = "Int32";
frontDistance.Scope = "Input";

y = Stateflow.Data(ch);
y.Name = "driveControl_send";
y.Scope = "Output";


%Add Transition
Idle_WaitforCoordinator = Stateflow.Transition(driveControlport);
WaitforCoordinator_Idle = Stateflow.Transition(driveControlport);
WaitforCoordinator_WaitForOvertaking = Stateflow.Transition(driveControlport);
WaitForOvertaking_Idle = Stateflow.Transition(driveControlport);

Idle_WaitforCoordinator.Source = Idle;
Idle_WaitforCoordinator.Destination = WaitforCoordinator;
Idle_WaitforCoordinator.DestinationOClock = 8;
Idle_WaitforCoordinator.LabelString = "[communicator_recv==1]{send(OvertakingRequested,overtkingIniPort), coordination_Successfull = true;}";

WaitforCoordinator_Idle.Source = WaitforCoordinator;
WaitforCoordinator_Idle.Destination = Idle;
WaitforCoordinator_Idle.DestinationOClock = 3;
WaitforCoordinator_Idle.LabelString = "denyPermission{communicator_send = 4;}";

WaitforCoordinator_WaitForOvertaking.Source = WaitforCoordinator;
WaitforCoordinator_WaitForOvertaking.Destination = WaitForOvertaking;
WaitforCoordinator_WaitForOvertaking.LabelString = "grantPermission{communicator_send = 1;}";

WaitForOvertaking_Idle.Source = WaitForOvertaking;
WaitForOvertaking_Idle.Destination = Idle;
WaitForOvertaking_Idle.LabelString = "[communicator_recv == 2]{send(executedOvertaking.overtakingInitPort);}";

sfsave;


