function euler_nb = DCM2Euler( DCMbn )
%    euler = [phi theta psi]
%

phi = atan2(DCMbn(3,2) , DCMbn(3,3));
theta = atan(-DCMbn(3,1) / ...
    sqrt(DCMbn(3,2) * DCMbn(3,2) + DCMbn(3,3) * DCMbn(3,3)));
psi = atan2(DCMbn(2,1) , DCMbn(1,1));

euler_nb = [phi theta psi]';
end

