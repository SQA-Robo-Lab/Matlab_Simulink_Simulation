function generateRoboCar(modelname)

if nargin == 0 
     modelname = 'RoboCar_test_4';
end 
new_system(modelname,'subsystem');

load_system('driveControl_Component');
%add_block('driveControl_Component','RoboCar_test5/driveControl');

add_block('built-in/Subsystem','RoboCar_test_4/DriveControll_Comp');

Simulink.BlockDiagram.copyContentsToSubsystem('driveControl_Component','RoboCar_test_4/DriveControll_Comp');

load_system('DriveSubsystem3.slx');
%add_block('simulink/Ports & Subsystems/Subsysstem','RoboCar_test90/driveControl');
%add_block('built-in/Subsystem','RoboCar_test90/Subsystem1'); 
add_block('built-in/Subsystem','RoboCar_test_4/Controller_Comp');
Simulink.BlockDiagram.copyContentsToSubsystem('DriveSubsystem3','RoboCar_test_4/Controller_Comp');
Simulink.BlockDiagram.arrangeSystem(modelname);
save_system(modelname);
close_system(modelname);