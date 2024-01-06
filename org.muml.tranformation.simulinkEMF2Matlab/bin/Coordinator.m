modelname = 'Coordinator'; 
open_system(new_system(modelname,"Subsystem"));
%Add Ports

%add Stateflowchart to Subsystem
load_system('CoordinatorComponent');
Simulink.BlockDiagram.copyContentsToSubsystem('CoordinatorComponent',modelname)

%Add Inports

%Add IN/Out Bus
%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/InBus1']',...,
    'MakeNameUnique','on',..., 
    'PortName', "communicator_recv");

add_block('simulink/Sources/In1','Coordinator/Chart/communicator_recv');
add_line('Coordinator','InBus1/1','Chart/1');


add_block('simulink/Ports & Subsystems/Out Bus Element', [gcs '/OutBus1']',...,
    'MakeNameUnique','on',..., 
    'PortName', "communicator_send");

add_block('simulink/Ports & Subsystems/Out1','Coordinator/Chart/communicator_send');
add_line('Coordinator','Chart/1','OutBus1/1');


%Add IN/Out Bus
%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/InBus2']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingInitiator_recv");

add_block('simulink/Sources/In1','Coordinator/Chart/overtakingInitiator_recv');
add_line('Coordinator','InBus2/1','Chart/2');


add_block('simulink/Ports & Subsystems/Out Bus Element', [gcs '/OutBus2']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingInitiator_send");

add_block('simulink/Ports & Subsystems/Out1','Coordinator/Chart/overtakingInitiator_send');
add_line('Coordinator','Chart/2','OutBus2/1');


%Add IN/Out Bus
%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/InBus3']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingAffiliate_recv");

add_block('simulink/Sources/In1','Coordinator/Chart/overtakingAffiliate_recv');
add_line('Coordinator','InBus3/1','Chart/3');


add_block('simulink/Ports & Subsystems/Out Bus Element', [gcs '/OutBus3']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingAffiliate_send");

add_block('simulink/Ports & Subsystems/Out1','Coordinator/Chart/overtakingAffiliate_send');
add_line('Coordinator','Chart/3','OutBus3/1');






Simulink.BlockDiagram.arrangeSystem(Coordinator);
save_system(Coordinator);
close_system(Coordinator);

