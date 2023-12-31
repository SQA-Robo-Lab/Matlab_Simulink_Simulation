modelname = 'fastAndSlowCar_v2'
open_system(new_system(modelname));


model = 'RoboCar';
load_system(model);

add_block('built-in/Subsystem','fastAndSlowCar_v2/fastCar_RoboCar')
Simulink.BlockDiagram.copyContentsToSubsystem('RoboCar','fastAndSlowCar_v2/fastCar_RoboCar');
set_param('fastAndSlowCar_v2/fastCar_RoboCar','TreatAsAtomicUnit','on');

Simulink.SubSystem.convertToModelReference(...
   'fastAndSlowCar_v2/fastCar_RoboCar', ...
   'fastCar_RoboCar', ...
   'ReplaceSubsystem',true);


model = 'RoboCar';
load_system(model);

add_block('built-in/Subsystem','fastAndSlowCar_v2/slowCar_RoboCar')
Simulink.BlockDiagram.copyContentsToSubsystem('RoboCar','fastAndSlowCar_v2/slowCar_RoboCar');
set_param('fastAndSlowCar_v2/slowCar_RoboCar','TreatAsAtomicUnit','on');

Simulink.SubSystem.convertToModelReference(...
   'fastAndSlowCar_v2/slowCar_RoboCar', ...
   'slowCar_RoboCar', ...
   'ReplaceSubsystem',true);

Simulink.BlockDiagram.arrangeSystem(modelname);
save_system(modelname);
close_system(modelname);
