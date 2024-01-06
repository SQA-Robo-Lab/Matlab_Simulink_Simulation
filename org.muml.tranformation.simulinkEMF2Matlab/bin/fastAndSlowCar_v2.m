modelname = 'fastAndSlowCar_v2'
open_system(new_system(modelname));


model = 'RoboCar';
load_system(model);

add_block('built-in/Subsystem','fastAndSlowCar_v2/fastCar')
Simulink.BlockDiagram.copyContentsToSubsystem('RoboCar','fastAndSlowCar_v2/fastCar');
set_param('fastAndSlowCar_v2/fastCar','TreatAsAtomicUnit','on');

Simulink.SubSystem.convertToModelReference(...
   'fastAndSlowCar_v2/fastCar', ...
   'fastCar', ...
   'ReplaceSubsystem',true);


model = 'RoboCar';
load_system(model);

add_block('built-in/Subsystem','fastAndSlowCar_v2/slowCar')
Simulink.BlockDiagram.copyContentsToSubsystem('RoboCar','fastAndSlowCar_v2/slowCar');
set_param('fastAndSlowCar_v2/slowCar','TreatAsAtomicUnit','on');

Simulink.SubSystem.convertToModelReference(...
   'fastAndSlowCar_v2/slowCar', ...
   'slowCar', ...
   'ReplaceSubsystem',true);

Simulink.BlockDiagram.arrangeSystem(modelname);
save_system(modelname);
close_system(modelname);
