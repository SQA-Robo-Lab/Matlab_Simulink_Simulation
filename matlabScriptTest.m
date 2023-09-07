function matlabScriptTest(modelname) 
% NEW_MODEL Create a new, empty Simulink model
%    NEW_MODEL('MODELNAME') creates a new model with
%    the name 'MODELNAME'. Without the 'MODELNAME'
%    argument, the new model is named 'my_untitled'.
if nargin == 0 
     modelname = 'InstanceConfig';
end 
% create and open the model
open_system(new_system(modelname));
%create Subsysteme
add_block('simulink/Ports & Subsystems/Subsystem','InstanceConfig/driveControl');
add_block('simulink/Ports & Subsystems/Subsystem','InstanceConfig/communicator','position',[535,140,575,180]);

%add Ports
add_block('simulink/Sources/In1','InstanceConfig/frontDistance');
add_block('simulink/Sources/In1','InstanceConfig/rearDistance');


%add Stateflowchart to Subsystem
add_block('driveControl_StateflowChart.slx','InstanceConfig/driveControl/driveControl_StateflowChart')

%create input Ports
add_block('simulink/Sources/In1','InstanceConfig/driveControl/frontDistance');
add_block('simulink/Sources/In1','InstanceConfig/driveControl/rearDistance');


%Add Bus input
add_block('simulink/Ports & Subsystems/In Bus Element', [gcs '/Out Bus Element']',...,
    'MakeNameUnique','on',..., 
    'PortName','driveControl_recv')

%Output Ports
add_block('simulink/Ports & Subsystems/Out1','InstanceConfig/driveControl/velocity');
add_block('simulink/Ports & Subsystems/Out Bus Element',...
    [gcs '/Out Bus Element'],...
    'MakeNameUnique','on',...
    'Position','[290 125 300 135]', ...
    'PortName','driveControl_send')

%add_block('simulink/Sources/Out','InstanceConfig/driveControl/driveControl_send');

%create Connection
add_line('InstanceConfig','InstanceConfig/frontDistance','InstanceConfig/driveControl/frontDistance');
add_line('InstanceConfig','In2/1','Add1/2');
add_line('InstanceConfig','Add1/1','Out1/1');

%save_system(modelname);
