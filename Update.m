clear;clc;
load('data.mat');
load('data_PureINS.mat');
constant;

global OMEGAe;
STARTTIME = 184401;
%DATANUM = 2e5;
DATANUM =  length(data) - STARTTIME;

samplingData = data(1,:);
gyroData = data(2:4,:);
fData = data(5:7,:);
output = zeros(DATANUM - 1,10);

%% origin value
LAT0 = 23.1373950708 * pi / 180;
LON0 = 113.3713651222 * pi / 180;
H0 = 2.175;
ROLL0 = 0.0107951084511778 * pi / 180;
PITCH0 = -2.14251290749072 * pi / 180;
YAW0 = -75.7498049314083 * pi / 180;

EULER0 = [ROLL0  PITCH0 YAW0]';
q = Euler2Qua(EULER0);
dcm = Euler2DCM(EULER0);
%dcm = orth(dcm);

count = 0;
%% Update
[rm , rn] = ROfCurvature(LAT0);
f = fData(:,STARTTIME);
gyro = gyroData(:,STARTTIME);

f1 = f;
gyro1= gyro;

g = [0 0 gravity(LAT0,H0)]';
omega_ie1 = [OMEGAe * cos(LAT0) , 0 , -OMEGAe * sin(LAT0)]';
velocity = [0 0 0]';
omega_en1 = [0 0 0]';
location = [LAT0 LON0 H0]';

location1 = location;
velocity1 = velocity;

for i = STARTTIME + 1:DATANUM + STARTTIME 
    sampling = samplingData(i) - samplingData(i - 1);
    if sampling < 1e-4
        continue;
    end
    count = count + 1;
    
    f1 = f; gyro1 = gyro;
    f = fData(:,i); gyro = gyroData(:,i);
    
    %% Update velocity
    
    %coriols velocity
    location_05 = (3 * location - location1) * 0.5;
    velocity_05 = (3 * velocity - velocity1) * 0.5;
    [rm , rn] = ROfCurvature(location_05(1));
    omega_ie_05 = [OMEGAe * cos(location_05(1)) , 0, -OMEGAe * sin(location_05(1))]';
    omega_en_05 = [velocity_05(2) / (rn + location_05(3))
                  -velocity_05(1) / (rm + location_05(3))
                  -velocity_05(2) * tan(location_05(1)) / (rn + location_05(3))];
    g_05 = [0, 0, gravity(location_05(1),location_05(3))]';
    
    v_coriols = g_05 - cross((2 * omega_ie_05 + omega_en_05),velocity_05);
    v_coriols = v_coriols * sampling;
 
    %v_fk ---use ppt
    zeta = (omega_ie_05 + omega_en_05) * sampling;
    v_fb = f + 0.5 * cross(gyro,f) + 1 / 12 * (cross(gyro1,f) + cross(f1,gyro));
    v_fk = (eye(3,3) - 0.5 * GetCompanionMatrix(zeta)) * dcm * v_fb;
    
    currentVelocity = velocity + v_fk + v_coriols; 
    
    %% Update location
    
    h = location(3) - 0.5 * (velocity(3) + velocity1(3)) * sampling;
    
    meanH = 0.5 * (location1(3) + location(3));
    lat = location(1) + 0.5 * (velocity(1) + velocity1(1)) / (rm + meanH) * sampling;
    meanLat = 0.5 * (location1(1) + location(1));
    [rm , rn] = ROfCurvature(meanLat);
    lon = location(2) + 0.5 * (velocity(2) + velocity1(2)) / (rn + meanH) / cos(meanLat) * sampling;
    
    currentLocation = [lat lon h]';
    
    %% update attitude
    
    % --- use quaternion
    phik = gyro + 1 / 12 * cross(gyro1 , gyro);
    normPhik = norm(phik);
    phik = sin(0.5 * normPhik) * phik / normPhik;
    qb = [cos(0.5 * normPhik);
           phik];
    
    normZeta = norm(zeta);
    qn = [1 - 1 / 8 * normZeta * normZeta;
             -0.5 * zeta];
    qnq = QuatMulti(qn,q);
    q = QuatMulti(qnq,qb);
    q = q / norm(q);
     
    dcm = Qua2DCM(q);
     
    velocity1 = velocity;
    velocity = currentVelocity;
     
    location1 = location;
    location = currentLocation;
     
    attitude = DCM2Euler(dcm);
     
    output(count , 1) = samplingData(i);
    output(count , 2:4) = location';
    output(count , 5:7) = velocity';
    output(count , 8:10) = attitude';
end

LAT = output(:,2);LON = output(:,3);H = output(:,4);
VN = output(:,5);VE = output(:,6);VD = output(:,7);
ROLL = output(:,8);PITCH = output(:,9);YAW = output(:,10);

errorLan = data_PureINS(2,1:DATANUM)' - output(1:DATANUM,2) * 180 /pi;
errorLon = data_PureINS(3,1:DATANUM)' - output(1:DATANUM,3) * 180 /pi;
errorH = data_PureINS(4,1:DATANUM)' - output(1:DATANUM,4);

errorVx = data_PureINS(5,1:DATANUM)' - output(1:DATANUM,5);
errorVy = data_PureINS(6,1:DATANUM)' - output(1:DATANUM,6);
errorVz = data_PureINS(7,1:DATANUM)' - output(1:DATANUM,7);

errorRoll = data_PureINS(8,1:DATANUM)' - output(1:DATANUM,8) * 180 /pi;
errorPitch = data_PureINS(9,1:DATANUM)' - output(1:DATANUM,9) * 180 / pi;
errorYaw = data_PureINS(10,1:DATANUM)' - output(1:DATANUM,10) * 180 /pi;















