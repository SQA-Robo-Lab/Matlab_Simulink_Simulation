function ch = createStateflowCharts
%rt = sfroot;
%ch = find(sfroot,"-isa","Stateflow.State",Name="On")
%prev_machines = find(rt,"-isa","Stateflow.Machine");
sfnew;
ch = find(sfroot,"-isa","Stateflow.Chart");
communicatorPort = Stateflow.State(ch);
communicatorPort.Name = "communicatorPort";
communicatorPort.Position = [50 50 400 200];
Idle = Stateflow.State(communicatorPort);
Idle.Name = "Idle";
Idle.Position = [80 120 90 60];
WaitforCoordinator = Stateflow.State(communicatorPort);
WaitforCoordinator.Name = "WaitforCoordinator";
WaitForOvertaking = Stateflow.State(communicatorPort);
WaitForOvertaking.Name = "WaitForOvertaking";
WaitforCoordinator.Position = [240 120 90 60];
WaitForOvertaking.Position = [120 180 90 60];

%Add default Transistion
dtcommunicatorPort = Stateflow.Transition(ch);
dtcommunicatorPort.Destination = communicatorPort;


dtA = Stateflow.Transition(ch);
dtA.Destination = Idle;
%dtA.DestinationOClock = 0;

%Add Transition
Idle_WaitforCoordinator = Stateflow.Transition(ch);
WaitforCoordinator_Idle = Stateflow.Transition(ch);
WaitforCoordinator_WaitForOvertaking = Stateflow.Transition(ch);
WaitForOvertaking_Idle = Stateflow.Transition(ch);

Idle_WaitforCoordinator.Source = Idle;
Idle_WaitforCoordinator.Destination = WaitforCoordinator;
Idle_WaitforCoordinator.LabelString = "[communicator_recv==1]{send(OvertakingRequested,overtkingIniPort), coordination_Successfull = true;}";
%Idle_WaitforCoordinator.SourceOClock = 3;
%dle_WaitforCoordinator.DestinationOClock = 9;

WaitforCoordinator_Idle.Source = WaitforCoordinator;
WaitforCoordinator_Idle.Destination = Idle;
WaitforCoordinator_Idle.LabelString = "denyPermission{communicator_send = 4;}";

WaitforCoordinator_WaitForOvertaking.Source = WaitforCoordinator;
WaitforCoordinator_WaitForOvertaking.Destination = WaitForOvertaking;
WaitforCoordinator_WaitForOvertaking.LabelString = "grantPermission{communicator_send = 1;}";

WaitForOvertaking_Idle.Source = WaitForOvertaking;
WaitForOvertaking_Idle.Destination = Idle;
WaitForOvertaking_Idle.LabelString = "[communicator_recv == 2]{send(executedOvertaking.overtakingInitPort);}";