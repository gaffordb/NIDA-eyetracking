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
eyeData = getfield(data, 'eyeData');

unnecessaryEye = {'Gaze_Calib','Gaze_Rot_L_Y', 'Gaze_Rot_L_X', ...
               'Gaze_Rot_L_X', 'Gaze_Qual_L', 'Gaze_Rot_R_Y', 'Gaze_Rot_R_X', 'Gaze_Qual_R', 'Hrot_Filt_Q3', 'Hrot_Filt_Q2', 'Hrot_Filt_Q1', 'Hrot_Filt_Q0', 'Hpos_Filt_Z', 'Hpos_Filt_Y', 'Hpos_Filt_X', 'Combined_World_X', 'Combined_World_Y', 'Combined_World_Z', 'Combined_Plane_X', 'Combined_Plane_Y', 'Combined_Pixel_X', 'Combined_Pixel_Y', 'Head_World_X', 'Head_World_Y', 'Head_World_Z', 'Head_Plane_X', 'Head_Plane_Y', 'Head_Pixel_X', 'Head_Pixel_Y'};

% Delete unnecessary fields for analysis
unnecessaryElem = {'AUX_CabMiscButtons','AUX_SteeringWheelButtons', ...
                   'CFS_Auto_Transmission_Mode', 'CFS_Steering_Wheel_Angle','CFS_Steering_Wheel_Angle_Rate', 'CFS_Transmission_Gear', 'CIS_Cruise_Control', 'CIS_Entertainment_Status', 'CIS_Horn','SCC_Audio_Trigger', 'SCC_DynObj_CvedId', 'SCC_DynObj_DataSize', 'SCC_DynObj_HcsmType', 'SCC_DynObj_Heading', 'SCC_DynObj_Name', 'SCC_DynObj_Pos', 'SCC_DynObj_RollPitch', 'SCC_DynObj_SolId', 'SCC_DynObj_Vel', 'SCC_Lane_Depart_Warn', 'SCC_OwnVeh_Curvature', 'VDS_Chassis_CG_Accel', 'VDS_Eyepoint_Pos', 'VDS_Veh_Heading_Fixed'};

elemData = rmfield(elemData,unnecessaryElem);
eyeData = rmfield(eyeData, unnecessaryEye);

elemfname = strcat('ReducedDataElem' filesep, strrep(filename, 'RawData' ...
                                                  filesep,''));

eyefname = strcat('ReducedDataEye' filesep, strrep(filename, 'RawData' ...
                                                  filesep,''));

% Save into new directory
save(elemfname, 'elemData')
save(eyefname, 'eyeData')
end
