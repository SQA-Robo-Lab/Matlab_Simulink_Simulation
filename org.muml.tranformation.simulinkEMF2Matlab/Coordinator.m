modelname = 'Coordinator'; 
open_system(new_system(modelname,"Subsystem"));
%Add Ports
%add Stateflowchart to Subsystem
load_system('CoordinatorComponent');
Simulink.BlockDiagram.copyContentsToSubsystem('CoordinatorComponent',modelname)

%Add IN/Out Bus
%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/In Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName', "communicator_recv");
add_block('simulink/Ports & Subsystems/Out Bus Element', [gcs '/Out Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName', "communicator_send");
%Add IN/Out Bus
%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/In Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingInitiator_recv");
add_block('simulink/Ports & Subsystems/Out Bus Element', [gcs '/Out Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingInitiator_send");
%Add IN/Out Bus
%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/In Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingAffiliate_recv");
add_block('simulink/Ports & Subsystems/Out Bus Element', [gcs '/Out Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingAffiliate_send");
Simulink.BlockDiagram.arrangeSystem(Coordinator);
save_system(Coordinator);
close_system(Coordinator);
