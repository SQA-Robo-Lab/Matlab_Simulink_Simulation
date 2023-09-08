function matlabScriptCreateDriveControl(modelname) 
% NEW_MODEL Create a new, empty Simulink model
%    NEW_MODEL('MODELNAME') creates a new model with
%    the name 'MODELNAME'. Without the 'MODELNAME'
%    argument, the new model is named 'my_untitled'.
if nargin == 0 
     modelname = 'driveControl_Component';
end 
% create and open the model
open_system(new_system(modelname,"Subsystem"));

%new_system(modelname,"Subsystem");

%add Sateflowchart
%set_param(driveControl,'driveControl')
%bh = Simulink.findBlocks('driveControl_StateflowChart');
%Simulink.BlockDiagram.createSubsystem(bh);


%open_system('driveControl_StateflowChart10');

load_system('driveControl_StateflowChart10');
%add_block('built-in/Subsystem', "driveControl26/DriveControl");
Simulink.BlockDiagram.copyContentsToSubsystem('driveControl_StateflowChart10',modelname);

%add_block('DriveSubsystem3','driveControl/driveConrol_Chart');

%load_system('driveControl-StateflowChart8');

%add input Ports hybrids 
add_block('simulink/Sources/In1','driveControl_Component/frontDistance');
add_block('simulink/Sources/In1','driveControl_Component/rearDistance');

%set Position
set_param('driveControl_Component/frontDistance','position',[50,50,90,70]);
set_param('driveControl_Component/rearDistance','position',[50,130,90,150]);

%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/Out Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName','driveControl_recv');


%Output Ports
add_block('simulink/Ports & Subsystems/Out1','driveControl_Component/velocity');
set_param('driveControl_Component/velocity','position',[500,80,540,100]);


%Add Output Bus
add_block('simulink/Ports & Subsystems/Out Bus Element',...
    [gcs '/Out Bus Element'],...
    'MakeNameUnique','on',...s
    'Position','[290 125 300 135]', ...
    'PortName','driveControl_send');

save_system('driveControl_Component');

%close ad the end
%close_system(model);