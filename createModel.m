function createModel(modelname)

if nargin == 0 
     modelname = 'Instance_ConfigTest5';
end 

open_system(new_system(modelname));
load_system('RoboCar_test_4');

%add_block('built-in/Subsystem','RoboCar_test97/RoboCar');
%set_param(gcb, 'ReferencedSubsystem', 'RoboCar_test97');

add_block('built-in/Subsystem','Instance_ConfigTest5/Fast_Car');

Simulink.BlockDiagram.copyContentsToSubsystem('RoboCar_test_4','Instance_ConfigTest5/Fast_Car');
set_param('Instance_ConfigTest5/Fast_Car','TreatAsAtomicUnit','on');


Simulink.SubSystem.convertToModelReference(...
   'Instance_ConfigTest5/Fast_Car', ...
   'Robo_Car', ...
   'ReplaceSubsystem',true);



%Simulink.SubSystem.convertToModelReference('RoboCar_test97', modelname);

%Simulink.SubSystem.convertToModelReference('RoboCar_test97','UseConversionAdvisor','fastCar');

%Simulink.SubSystem.convertToModelReference(...
%{'RoboCar_test97','RoboCar_test97'},...
%{'fastCar','slowCar'},...
%'ReplaceSubsystem',true,...
%'AutoFix',true,...
%'CheckSimulationResults',true)

%Simulink.SubSystem.convertToModelReference(gcb,'UseConversionAdvisor',true);

%load_system('RoboCar_test97');
%
%Simulink.SubSystem.convertToModelReference('RoboCar_test97','Instance_ConfigTest35');


save_system(modelname);

