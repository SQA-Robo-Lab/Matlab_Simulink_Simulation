function matlabScriptCreateDriveControl(modelname) 
% NEW_MODEL Create a new, empty Simulink model
%    NEW_MODEL('MODELNAME') creates a new model with
%    the name 'MODELNAME'. Without the 'MODELNAME'
%    argument, the new model is named 'my_untitled'.
if nargin == 0 
     modelname = 'driveControl';
end 
% create and open the model
open_system(new_system(modelname));

%add Sateflowchart
%set_param(driveControl,'driveControl')
%bh = Simulink.findBlocks('driveControl_StateflowChart');
%Simulink.BlockDiagram.createSubsystem(bh);


add_block('Copy_of_driveControl','driveControl/driveConrol_Chart');


%add input Ports hybrids 
add_block('simulink/Sources/In1','driveControl/frontDistance');
add_block('simulink/Sources/In1','driveControl/rearDistance');

%set Position
set_param('driveControl/frontDistance','position',[50,50,90,70]);
set_param('driveControl/rearDistance','position',[50,130,90,150]);

%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/Out Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName','driveControl_recv');



%Output Ports
add_block('simulink/Ports & Subsystems/Out1','driveControl/velocity');
set_param('driveControl/velocity','position',[500,80,540,100]);


%Add Output Bus
add_block('simulink/Ports & Subsystems/Out Bus Element',...
    [gcs '/Out Bus Element'],...
    'MakeNameUnique','on',...
    'Position','[290 125 300 135]', ...
    'PortName','driveControl_send');

save_system('driveControl');

%close ad the end
%close_system('driveControl');