function Qua = Euler2Qua( euler_nb )
%    euler = [phi theta psi]
%

phi = euler_nb(1);
theta = euler_nb(2);
psi = euler_nb(3);

cphi2 = cos(phi / 2); sphi2 = sin(phi / 2);
ctheta2 = cos(theta / 2); stheta2 = sin(theta / 2);
cpsi2 = cos(psi / 2); spsi2 = sin(psi / 2);

q0 = cphi2 * ctheta2 * cpsi2 + sphi2 * stheta2 * spsi2;
q1 = sphi2 * ctheta2 * cpsi2 - cphi2 * stheta2 * spsi2;
q2 = cphi2 * stheta2 * cpsi2 + sphi2 * ctheta2 * spsi2;
q3 = cphi2 * ctheta2 * spsi2 - sphi2 * stheta2 * cpsi2;

Qua = [q0 q1 q2 q3]';
Qua = Qua/norm(Qua);
end

