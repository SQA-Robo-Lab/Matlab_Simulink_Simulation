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



%load StatefowChart and copy in DriveControl
load_system('driveControl_StateflowChart139');
%add_block('built-in/Subsystem', "driveControl26/DriveControl");
Simulink.BlockDiagram.copyContentsToSubsystem('driveControl_StateflowChart139',modelname);

%load_system('driveControl-StateflowChart8');

%add input Ports hybrids 
add_block('simulink/Sources/In1','driveControl_Component/frontDistance');
add_block('simulink/Sources/In1','driveControl_Component/rearDistance');

%set Position
%set_param('driveControl_Component/frontDistance','position',[50,50,90,70]);
%set_param('driveControl_Component/rearDistance','position',[50,130,90,150]);

%Add Bus input for discrete ports
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/Out Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName','driveControl_recv');

%Output Ports
add_block('simulink/Ports & Subsystems/Out1','driveControl_Component/velocity');
%set_param('driveControl_Component/velocity','position');

%Add Output Bus
add_block('simulink/Ports & Subsystems/Out Bus Element',...
    [gcs '/Out Bus Element'],...
    'MakeNameUnique','on',...
    'PortName','driveControl_send');




%Add transitions
inputHndl = get_param('driveControl_Component/frontDistance','PortHandles');
productHndl = get_param('driveControl_Component/Chart','PortHandles');

add_line(modelname,inputHndl.Outport(1),productHndl.Inport(1),'autorouting','on');

inputHndl = get_param('driveControl_Component/rearDistance','PortHandles');
add_line(modelname,inputHndl.Outport(1),productHndl.Inport(2),'autorouting','on');

inputHndl = get_param('driveControl_Component/velocity','PortHandles');
add_line(modelname,productHndl.Outport(2),inputHndl.Inport(1),'autorouting','on');

%inputHndl = get_param('driveControl_Component','PortHandles');
%add_line(modelname,productHndl.Outport(1),'signal1','autorouting','on');

%set_param(gcb,'OutputSignals',productHndl.Inport(3));
 
%Simulink.Bus.addElementToPort(modelname,"driveControl_recv",'driveControl_Component/Chart');

%Simulink.Bus.addElementToPort(modelname,productHndl.Outport(1),"driveControl_send");



lineHandles = find_system(gcs,'FindAll','On','SearchDepth',1,'Type','Line');
Simulink.BlockDiagram.routeLine(lineHandles);
Simulink.BlockDiagram.arrangeSystem(modelname);
save_system(modelname);

%close ad the end
%close_system(model);