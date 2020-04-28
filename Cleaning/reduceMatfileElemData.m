files = dir('RawData' filesep 'MatFiles' filesep);
for i = 3:(length(files)-1)
    filename = strcat('RawData' filesep 'MatFiles' filesep, files(i).name);
    reduceFile(filename);
    disp(filename);
end

function reduceFile(filename)
%reduceFile(filename)
%  Imports data and extract 'elemDataI' from file
%  filename: filepath
data = load('-mat', filename);

% Get 'elemDataI' and rename
elemData = getfield (data, 'elemDataI');

% Delete unnecessary fields for analysis
unnecessary = {'AUX_CabMiscButtons','AUX_SteeringWheelButtons', 'CFS_Auto_Transmission_Mode', 'CFS_Steering_Wheel_Angle','CFS_Steering_Wheel_Angle_Rate', 'CFS_Transmission_Gear', 'CIS_Cruise_Control', 'CIS_Entertainment_Status', 'CIS_Horn','SCC_Audio_Trigger', 'SCC_DynObj_CvedId', 'SCC_DynObj_DataSize', 'SCC_DynObj_HcsmType', 'SCC_DynObj_Heading', 'SCC_DynObj_Name', 'SCC_DynObj_Pos', 'SCC_DynObj_RollPitch', 'SCC_DynObj_SolId', 'SCC_DynObj_Vel', 'SCC_Lane_Depart_Warn', 'SCC_OwnVeh_Curvature', 'VDS_Chassis_CG_Accel', 'VDS_Eyepoint_Pos', 'VDS_Veh_Heading_Fixed'};
elemData = rmfield(elemData,unnecessary);
newfilename = strcat('ReducedData' filesep, strrep(filename, 'RawData' ...
                                                  filesep,''));

% Save into new directory
save(newfilename,'elemData')
end
