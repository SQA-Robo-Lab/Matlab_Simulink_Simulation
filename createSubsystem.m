function createSubsystem (subsystemem)

new_system('Controller','subsystem');


%add input Ports hybrids 
add_block('simulink/Sources/In1','Controller/frontDistance');
add_block('simulink/Sources/In1','Controller/rearDistance');

%set Position
set_param('Controller/frontDistance','position',[50,50,90,70]);
set_param('Controller/rearDistance','position',[50,130,90,150]);

%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/Out Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName','driveControl_recv');



%Output Ports
add_block('simulink/Ports & Subsystems/Out1','Controller/velocity');
set_param('Controller/velocity','position',[500,80,540,100]);


%Add Output Bus
add_block('simulink/Ports & Subsystems/Out Bus Element',...
    [gcs '/Out Bus Element'],...
    'MakeNameUnique','on',...
    'Position','[290 125 300 135]', ...
    'PortName','driveControl_send');

save_system('Controller');
