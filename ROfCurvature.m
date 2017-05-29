function [ rm, rn ] = ROfCurvature( latitude )
%calculate Rm and Rn
global POWE Ra;

s2lat = sin(latitude);
s2lat = s2lat * s2lat;

temp = sqrt(1 - POWE * s2lat);

rm = Ra * (1 - POWE) / (temp * temp * temp);
rn = Ra / temp;

end

