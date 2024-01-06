modelname = 'DriveControl'; 
open_system(new_system(modelname,"Subsystem"));
%Add Ports

%add Stateflowchart to Subsystem
load_system('DriveControlComponent');
Simulink.BlockDiagram.copyContentsToSubsystem('DriveControlComponent',modelname)

%Add Inports
add_block('simulink/Sources/In1','DriveControl/IN_frontDistance');
add_block('simulink/Sources/In1','DriveControl/Chart/IN_frontDistance');
add_line('DriveControl','IN_frontDistance/1','Chart/1');
add_block('simulink/Sources/In1','DriveControl/IN_rearDistance');
add_block('simulink/Sources/In1','DriveControl/Chart/IN_rearDistance');
add_line('DriveControl','IN_rearDistance/1','Chart/2');

%Add Outports
add_block('simulink/Ports & Subsystems/Out1','DriveControl/OUT_velocity');
add_block('simulink/Ports & Subsystems/Out1','DriveControl/Chart/OUT_velocity');

add_line('DriveControl','Chart/1','OUT_velocity/1');

%Add IN/Out Bus
%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/InBus2']',...,
    'MakeNameUnique','on',..., 
    'PortName', "driveControl_recv");

add_block('simulink/Sources/In1','DriveControl/Chart/driveControl_recv');
add_line('DriveControl','InBus2/1','Chart/3');


add_block('simulink/Ports & Subsystems/Out Bus Element', [gcs '/OutBus3']',...,
    'MakeNameUnique','on',..., 
    'PortName', "driveControl_send");

add_block('simulink/Ports & Subsystems/Out1','DriveControl/Chart/driveControl_send');
add_line('DriveControl','Chart/2','OutBus3/1');






Simulink.BlockDiagram.arrangeSystem(DriveControl);
save_system(DriveControl);
close_system(DriveControl);

