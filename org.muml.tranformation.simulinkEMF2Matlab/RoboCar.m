modelname = 'RoboCar'; 
open_system(new_system(modelname,"Subsystem"));
%Add Ports
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
%Add subb 
load_system('_cy3_-6DFEe6cVqS7pZcxCA');
add_block('built-in/Subsystem', 'RoboCar/rearDistanceSensor');
Simulink.BlockDiagram.copyContentsToSubsystem('_cy3_-6DFEe6cVqS7pZcxCA','RoboCar/rearDistanceSensor');
%Add subb 
load_system('_cy3__aDFEe6cVqS7pZcxCA');
add_block('built-in/Subsystem', 'RoboCar/powerTrain');
Simulink.BlockDiagram.copyContentsToSubsystem('_cy3__aDFEe6cVqS7pZcxCA','RoboCar/powerTrain');
%Add subb 
load_system('_cy3__6DFEe6cVqS7pZcxCA');
add_block('built-in/Subsystem', 'RoboCar/driveControl');
Simulink.BlockDiagram.copyContentsToSubsystem('_cy3__6DFEe6cVqS7pZcxCA','RoboCar/driveControl');
%Add subb 
load_system('_cy4AAKDFEe6cVqS7pZcxCA');
add_block('built-in/Subsystem', 'RoboCar/communicator');
Simulink.BlockDiagram.copyContentsToSubsystem('_cy4AAKDFEe6cVqS7pZcxCA','RoboCar/communicator');
%Add subb 
load_system('_cy4ABKDFEe6cVqS7pZcxCA');
add_block('built-in/Subsystem', 'RoboCar/frontDistanceSensor');
Simulink.BlockDiagram.copyContentsToSubsystem('_cy4ABKDFEe6cVqS7pZcxCA','RoboCar/frontDistanceSensor');
Simulink.BlockDiagram.arrangeSystem(RoboCar);
save_system(RoboCar);
close_system(RoboCar);
