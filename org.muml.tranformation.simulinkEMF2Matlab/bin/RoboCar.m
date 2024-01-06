modelname = 'RoboCar'; 
open_system(new_system(modelname,"Subsystem"));
%Add Ports


%Add Inports

%Add IN/Out Bus
%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/InBus0']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingInitiator_recv");



add_block('simulink/Ports & Subsystems/Out Bus Element', [gcs '/OutBus0']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingInitiator_send");



%Add IN/Out Bus
%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/InBus1']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingAffiliate_recv");



add_block('simulink/Ports & Subsystems/Out Bus Element', [gcs '/OutBus1']',...,
    'MakeNameUnique','on',..., 
    'PortName', "overtakingAffiliate_send");




%Add subb 
load_system('DriveControl');
add_block('built-in/Subsystem', 'RoboCar/driveControl');
Simulink.BlockDiagram.copyContentsToSubsystem('DriveControl','RoboCar/driveControl');
%Add subb 
load_system('PowerTrain');
add_block('built-in/Subsystem', 'RoboCar/powerTrain');
Simulink.BlockDiagram.copyContentsToSubsystem('PowerTrain','RoboCar/powerTrain');
%Add subb 
load_system('DistanceSensor');
add_block('built-in/Subsystem', 'RoboCar/rearDistanceSensor');
Simulink.BlockDiagram.copyContentsToSubsystem('DistanceSensor','RoboCar/rearDistanceSensor');
%Add subb 
load_system('DistanceSensor');
add_block('built-in/Subsystem', 'RoboCar/frontDistanceSensor');
Simulink.BlockDiagram.copyContentsToSubsystem('DistanceSensor','RoboCar/frontDistanceSensor');
%Add subb 
load_system('Coordinator');
add_block('built-in/Subsystem', 'RoboCar/communicator');
Simulink.BlockDiagram.copyContentsToSubsystem('Coordinator','RoboCar/communicator');

add_line('RoboCar','rearDistanceSensor/OUT_distance/1','driveControl/IN_rearDistance/1');
add_line('RoboCar','frontDistanceSensor/OUT_distance/1','driveControl/IN_frontDistance/1');

add_line('RoboCar','driveControl/OUT_velocity/1','powerTrain/IN_velocity/1');






Simulink.BlockDiagram.arrangeSystem(RoboCar);
save_system(RoboCar);
close_system(RoboCar);

