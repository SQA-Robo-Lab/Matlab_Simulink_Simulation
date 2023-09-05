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
add_block('simulink/Ports & Subsystems/Subsystem','InstanceConfig/communicator');

add_block('simulink/Sources/In1','InstanceConfig/frontDistance');
add_block('simulink/Sources/In1','InstanceConfig/rearDistance');
add_block('simulink/Sources/In1','InstanceConfig/driveControl_recv');

%create Ports
add_block('simulink/Sources/In1','InstanceConfig/driveControl/frontDistance');
add_block('simulink/Sources/In1','InstanceConfig/driveControl/rearDistance');
add_block('simulink/Sources/In1','InstanceConfig/driveControl/driveControl_recv');
%add_block('simulink/Sources/Out','InstanceConfig/driveControl/velocity');
%add_block('simulink/Sources/Out','InstanceConfig/driveControl/driveControl_send');
%create Connection
add_line('InstanceConfig','In1/1','Add1/1');
add_line('InstanceConfig','In2/1','Add1/2');
add_line('InstanceConfig','Add1/1','Out1/1');

save_system(modelname);
