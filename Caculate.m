clear;clc;
WE = 7.2921151467e-5;%rotational angular velocity of the earth
longitude = -114.0248136140;
latitude = 51.2124539701;
altitude = 1077.393;

grav = [9.7803267715 0.0052790414 0.0000232718 -0.000003087691089 0.000000004397731 0.000000000000721];
sinB=sin(latitude * pi / 180);
sinB2=sinB*sinB;
sinB4=sinB2*sinB2;

g = grav(1) * (1.0 + grav(2) * sinB2+ grav(3) * sinB4) ...
    + (grav(4) + grav(5) * sinB2) * altitude + grav(6) * altitude* altitude;


load 'staticdata.txt';
staticdata = staticdata * 200;

gammaN = [0 0 -g]';
omegaN = [WE * cos(latitude * pi / 180) 0 -WE*sin(latitude * pi / 180)]';
upsilonN = cross(gammaN,omegaN);

gou = [gammaN omegaN upsilonN];
gou = inv(gou);


% ---------------MEAN ALL DATA------------------%
gammaB = [mean(staticdata(:,5)),mean(staticdata(:,6)),mean(staticdata(:,7))]';
omegaB = [mean(staticdata(:,2)),mean(staticdata(:,3)),mean(staticdata(:,4))]';
upsilonB = cross(gammaB,omegaB);

Cnb = [gammaB omegaB upsilonB] * gou ;
Cbn = Cnb';

yaw = atan(Cbn(2,1) / Cbn(1,1)) * 180 / pi
pitch = atan(-Cbn(3,1) / sqrt(Cbn(3,2) * Cbn(3,2) + Cbn(3,3) * Cbn(3,3))) * 180 / pi
roll = atan(Cbn(3,2) / Cbn(3,3)) * 180 / pi
% ---------------------------------------------%

%-------------MEAN EVERY SECOND DATA--------------%
yawSecond = zeros(1,70);
pitchSecond = yawSecond;
rollSecond = yawSecond;

for i = 0 : 70 - 1 
    gammaB = [mean(staticdata(i * 200 + 1:i * 200 + 200,5))
              mean(staticdata(i * 200 + 1:i * 200 + 200,6))
              mean(staticdata(i * 200 + 1:i * 200 + 200,7))];
    omegaB = [mean(staticdata(i * 200 + 1:i * 200 + 200,2))
              mean(staticdata(i * 200 + 1:i * 200 + 200,3))
              mean(staticdata(i * 200 + 1:i * 200 + 200,4))];
    upsilonB = cross(gammaB,omegaB);
    
    Cnb = [gammaB omegaB upsilonB] * gou;
    Cbn = Cnb';

    yawSecond(1,i + 1) = atan(Cbn(2,1) / Cbn(1,1));
    pitchSecond(1,i + 1) = atan(-Cbn(3,1) / sqrt(Cbn(3,2) * Cbn(3,2) + Cbn(3,3) * Cbn(3,3)));
    rollSecond(1,i + 1) = atan(Cbn(3,2) / Cbn(3,3));
end
subplot(3,1,1);plot(yawSecond * 180 / pi);
subplot(3,1,2);plot(pitchSecond * 180 / pi);
subplot(3,1,3);plot(rollSecond * 180 / pi);
%-------------------------------------------------------%


%-------------MEAN EVERY EPOCH DATA--------------%
yawEpoch = zeros(1,length(staticdata));
pitchEpoch = yawEpoch;
rollEpoch = yawEpoch;

for i = 1 : length(staticdata) 
    gammaB = [staticdata(i,5)
              staticdata(i,6)
              staticdata(i,7)];
          
    omegaB = [staticdata(i,2)
              staticdata(i,3)
              staticdata(i,4)];
    upsilonB = cross(gammaB,omegaB);
    
    Cnb = [gammaB omegaB upsilonB] * gou;
    Cbn = Cnb';

    yawEpoch(1,i) = atan(Cbn(2,1) / Cbn(1,1));
    pitchEpoch(1,i) = atan(-Cbn(3,1) / sqrt(Cbn(3,2) * Cbn(3,2) + Cbn(3,3) * Cbn(3,3)));
    rollEpoch(1,i) = atan(Cbn(3,2) / Cbn(3,3));
end
subplot(3,1,1);plot(yawEpoch * 180 / pi);
subplot(3,1,2);plot(pitchEpoch * 180 / pi);
subplot(3,1,3);plot(rollEpoch * 180 / pi);
%-------------------------------------------------------%