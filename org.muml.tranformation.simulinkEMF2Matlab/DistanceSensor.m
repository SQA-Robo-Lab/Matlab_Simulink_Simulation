modelname = 'DistanceSensor'; 
open_system(new_system(modelname,"Subsystem"));
%Add Ports
%Add Outports
add_block('simulink/Ports & Subsystems/Out1','DistanceSensor/OUT_distance');
Simulink.BlockDiagram.arrangeSystem(DistanceSensor);
save_system(DistanceSensor);
close_system(DistanceSensor);
