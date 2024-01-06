modelname = 'PowerTrain'; 
open_system(new_system(modelname,"Subsystem"));
%Add Ports


%Add Inports
add_block('simulink/Sources/In1','PowerTrain/IN_velocity');





Simulink.BlockDiagram.arrangeSystem(PowerTrain);
save_system(PowerTrain);
close_system(PowerTrain);

