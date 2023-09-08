function createSubsystem (subsystemem)

new_system('DriveSubsystem3','subsystem');




%add input Ports hybrids 
add_block('simulink/Sources/In1','DriveSubsystem2/frontDistance');
add_block('simulink/Sources/In1','DriveSubsystem2/rearDistance');

%set Position
set_param('DriveSubsystem2/frontDistance','position',[50,50,90,70]);
set_param('DriveSubsystem2/rearDistance','position',[50,130,90,150]);

%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/Out Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName','driveControl_recv');



%Output Ports
add_block('simulink/Ports & Subsystems/Out1','DriveSubsystem2/velocity');
set_param('DriveSubsystem2/velocity','position',[500,80,540,100]);


%Add Output Bus
add_block('simulink/Ports & Subsystems/Out Bus Element',...
    [gcs '/Out Bus Element'],...
    'MakeNameUnique','on',...
    'Position','[290 125 300 135]', ...
    'PortName','driveControl_send');

save_system('DriveSubsystem3');
