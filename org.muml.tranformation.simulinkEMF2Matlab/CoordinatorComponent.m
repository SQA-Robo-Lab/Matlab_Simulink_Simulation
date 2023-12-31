sfnew CoordinatorComponent;
ch = find(sfroot,"-isa","Stateflow.Chart");
%add Variables
coordinationTimeout =  Stateflow.Data(ch);
coordinationTimeout.name =  "coordinationTimeout";
coordinationTimeout.DataType = "int32";
coordinationTimeout.Scope = "Local";
coordinatorIsBusy =  Stateflow.Data(ch);
coordinatorIsBusy.name =  "coordinatorIsBusy";
coordinatorIsBusy.DataType = "boolean";
coordinatorIsBusy.Scope = "Local";
Coordinator_main = Stateflow.State(ch);
Coordinator_main.Name = "Coordinator_main";
Coordinator_main.Position = [10 10 1000 800];
Coordinator_main.Decomposition = "PARALLEL_AND"; 
communicatorPort = Stateflow.State(Coordinator_main);
communicatorPort.Name = "communicatorPort";
% x, y, lenghth, width
y = (1-1) *200 + (1-1) * 40 + 30;
y = 40
communicatorPort.Position =  [80 y 900 200];

Idle = Stateflow.State(communicatorPort);
Idle.Name = "Idle";
x =  100
y =  80
Idle.Position = [x y 90 60];
%add self transition
Self_Transition = Stateflow.Transition(communicatorPort);
Self_Transition.Destination = Idle;
Self_Transition.DestinationOClock = 0;
Self_Transition.SourceEndpoint = Self_Transition.DestinationEndpoint-[0 30];
Self_Transition.Midpoint = Self_Transition.DestinationEndpoint-[0 15];
WaitForCoordination = Stateflow.State(communicatorPort);
WaitForCoordination.Name = "WaitForCoordination";
x =  650
y =  80
WaitForCoordination.Position = [x y 90 60];
WaitForOvertaking = Stateflow.State(communicatorPort);
WaitForOvertaking.Name = "WaitForOvertaking";
x =  300
y =  120
WaitForOvertaking.Position = [x y 90 60];
Transition_ = Stateflow.Transition(communicatorPort)
Transition_.Source = Idle;
Transition_.Destination = WaitForCoordination;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "communicator_recv" + '==' + "GUARD_EVENT_1";
Transition_.LabelString = Transition_.LabelString + "send(overtakingRequested)";
Transition_ = Stateflow.Transition(communicatorPort)
Transition_.Source = WaitForCoordination;
Transition_.Destination = WaitForOvertaking;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "communicator_send" + '==' + "ACTION_SEND_4";
Transition_.LabelString = Transition_.LabelString + "coordinationSuccessful";
Transition_ = Stateflow.Transition(communicatorPort)
Transition_.Destination = Idle;
Transition_.Source = WaitForOvertaking;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "communicator_recv" + '==' + "GUARD_EVENT_7";
Transition_.LabelString = Transition_.LabelString + "send(overtakingSuccessful)";
Transition_ = Stateflow.Transition(communicatorPort)
Transition_.Destination = Idle;
Transition_.Source = WaitForCoordination;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "communicator_send" + '==' + "ACTION_SEND_2";
Transition_.LabelString = Transition_.LabelString + "coordinationSuccessful";


%Ports
communicator_recv =  Stateflow.Data(ch);
communicator_recv.name =  "communicator_recv";
communicator_recv.Scope = "Input";
communicator_send =  Stateflow.Data(ch);
communicator_send.name =  "communicator_send";
communicator_send.Scope = "Output";
overtakingInitiatorPort = Stateflow.State(Coordinator_main);
overtakingInitiatorPort.Name = "overtakingInitiatorPort";
% x, y, lenghth, width
y = (2-1) *200 + (2-1) * 40 + 30;
overtakingInitiatorPort.Position =  [80 y 900 200];

Idle = Stateflow.State(overtakingInitiatorPort);
Idle.Name = "Idle";
x =  100
y =  140 + 200
Idle.Position = [x y 90 60];
%add self transition
Self_Transition = Stateflow.Transition(overtakingInitiatorPort);
Self_Transition.Destination = Idle;
Self_Transition.DestinationOClock = 0;
Self_Transition.SourceEndpoint = Self_Transition.DestinationEndpoint-[0 30];
Self_Transition.Midpoint = Self_Transition.DestinationEndpoint-[0 15];
Initiating = Stateflow.State(overtakingInitiatorPort);
Initiating.Name = "Initiating";
x =  650
y =  120 +200
Initiating.Position = [x y 90 60];
Passing = Stateflow.State(overtakingInitiatorPort);
Passing.Name = "Passing";
x =  300
y =  200 + 200
Passing.Position = [x y 90 60];
Transition_ = Stateflow.Transition(overtakingInitiatorPort)
Transition_.Source = Idle;
Transition_.Destination = Initiating;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "";
Transition_.LabelString = Transition_.LabelString + "overtakingInitiator_send" + '==' + "ACTION_SEND_3";
Transition_.LabelString = Transition_.LabelString + "overtakingRequested";
Transition_ = Stateflow.Transition(overtakingInitiatorPort)
Transition_.Source = Initiating;
Transition_.Destination = Passing;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "overtakingInitiator_recv" + '==' + "GUARD_EVENT_6";
Transition_.LabelString = Transition_.LabelString + "send(coordinationSuccessful)";
Transition_ = Stateflow.Transition(overtakingInitiatorPort)
Transition_.Destination = Idle;
Transition_.Source = Passing;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "overtakingInitiator_send" + '==' + "ACTION_SEND_5";
Transition_.LabelString = Transition_.LabelString + "overtakingSuccessful";
Transition_ = Stateflow.Transition(overtakingInitiatorPort)
Transition_.Destination = Idle;
Transition_.Source = Initiating;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "overtakingInitiator_send" + '==' + "ACTION_SEND_5";
Transition_.LabelString = Transition_.LabelString + "send(coordinationSuccessful)";


%Ports
overtakingInitiator_recv =  Stateflow.Data(ch);
overtakingInitiator_recv.name =  "overtakingInitiator_recv";
overtakingInitiator_recv.Scope = "Input";
overtakingInitiator_send =  Stateflow.Data(ch);
overtakingInitiator_send.name =  "overtakingInitiator_send";
overtakingInitiator_send.Scope = "Output";
overtakingAffiliatePort = Stateflow.State(Coordinator_main);
overtakingAffiliatePort.Name = "overtakingAffiliatePort";
% x, y, lenghth, width
y = (3-1) *200 + (3-1) * 40 + 30;
overtakingAffiliatePort.Position =  [80 y 900 200];

Idle = Stateflow.State(overtakingAffiliatePort);
Idle.Name = "Idle";
x =  100
y =  140 + 400 +40
Idle.Position = [x y 90 60];
%add self transition
Self_Transition = Stateflow.Transition(overtakingAffiliatePort);
Self_Transition.Destination = Idle;
Self_Transition.DestinationOClock = 0;
Self_Transition.SourceEndpoint = Self_Transition.DestinationEndpoint-[0 30];
Self_Transition.Midpoint = Self_Transition.DestinationEndpoint-[0 15];
Coordinating = Stateflow.State(overtakingAffiliatePort);
Coordinating.Name = "Coordinating";
x =  650
y =  140 +400
Coordinating.Position = [x y 90 60];
GettingPassed = Stateflow.State(overtakingAffiliatePort);
GettingPassed.Name = "GettingPassed";
x =  300
y =  200 + 400
GettingPassed.Position = [x y 90 60];
Transition_ = Stateflow.Transition(overtakingAffiliatePort)
Transition_.Source = Idle;
Transition_.Destination = Coordinating;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "";
Transition_.LabelString = Transition_.LabelString + "overtakingAffiliate_recv" + '==' + "GUARD_EVENT_3";
Transition_ = Stateflow.Transition(overtakingAffiliatePort)
Transition_.Source = Coordinating;
Transition_.Destination = GettingPassed;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "overtakingAffiliate_send" + '==' + "ACTION_SEND_6";
Transition_ = Stateflow.Transition(overtakingAffiliatePort)
Transition_.Destination = Idle;
Transition_.Source = GettingPassed;
Transition_.LabelString = "";
Transition_.LabelString = Transition_.LabelString + "overtakingAffiliate_recv" + '==' + "GUARD_EVENT_5";


%Ports
overtakingAffiliate_recv =  Stateflow.Data(ch);
overtakingAffiliate_recv.name =  "overtakingAffiliate_recv";
overtakingAffiliate_recv.Scope = "Input";
overtakingAffiliate_send =  Stateflow.Data(ch);
overtakingAffiliate_send.name =  "overtakingAffiliate_send";
overtakingAffiliate_send.Scope = "Output";



sfsave;
