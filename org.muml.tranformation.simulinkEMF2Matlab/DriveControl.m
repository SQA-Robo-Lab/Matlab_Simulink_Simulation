modelname = 'DriveControl'; 
open_system(new_system(modelname,"Subsystem"));
%Add Ports
%add Stateflowchart to Subsystem
load_system('DriveControlComponent');
Simulink.BlockDiagram.copyContentsToSubsystem('DriveControlComponent',modelname)

%Add Inports
add_block('simulink/Sources/In1','DriveControl/IN_frontDistance');
%Add Inports
add_block('simulink/Sources/In1','DriveControl/IN_rearDistance');
%Add Outports
add_block('simulink/Ports & Subsystems/Out1','DriveControl/OUT_velocity');
%Add IN/Out Bus
%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/In Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName', "driveControl_recv");
add_block('simulink/Ports & Subsystems/Out Bus Element', [gcs '/Out Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName', "driveControl_send");
Simulink.BlockDiagram.arrangeSystem(DriveControl);
save_system(DriveControl);
close_system(DriveControl);
