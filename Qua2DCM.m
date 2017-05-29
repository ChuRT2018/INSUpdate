function [ DCMbn ] = Qua2DCM( q_bn )

q0 = q_bn(1);
q1 = q_bn(2);
q2 = q_bn(3);
q3 = q_bn(4);

DCMbn = zeros(3,3);

DCMbn(1,1) = q0 * q0 + q1 * q1 - q2 * q2 - q3 * q3;
DCMbn(2,2) = q0 * q0 - q1 * q1 + q2 * q2 - q3 * q3;
DCMbn(3,3) = q0 * q0 - q1 * q1 - q2 * q2 + q3 * q3;

DCMbn(1,2) = 2 * (q1 * q2 - q0 * q3);
DCMbn(2,1) = 2 * (q1 * q2 + q0 * q3);

DCMbn(1,3) = 2 * (q1 * q3 + q0 * q2);
DCMbn(3,1) = 2 * (q1 * q3 - q0 * q2);

DCMbn(2,3) = 2 * (q2 * q3 - q0 * q1);
DCMbn(3,2) = 2 * (q2 * q3 + q0 * q1);

%DCMbn = orth(DCMbn);
%DCMbn = orth(DCMbn);
end

