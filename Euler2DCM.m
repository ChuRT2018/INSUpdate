function DCMbn = Euler2DCM( euler_nb )
%    euler = [phi theta psi]
%

% phi = euler_nb(1); %x e
% theta = euler_nb(2); % y n
% psi = euler_nb(3); % z u
% 
% cphi = cos(phi);sphi = sin(phi);
% ctheta = cos(theta);stheta = sin(theta);
% cpsi = cos(psi);spsi = sin(psi);
% 
% CX = [cpsi  spsi 0
%       -spsi cpsi 0
%         0    0   1];
%   
% CY = [ctheta 0 -stheta
%         0    1    0
%       stheta 0 ctheta];
% CZ = [1   0    0
%       0 cphi  sphi
%       0 -sphi cphi];


% DCMnb = CZ * CY * CX;
% DCMbn = DCMnb';

phi = euler_nb(1);
theta = euler_nb(2);
psi = euler_nb(3);

cphi = cos(phi);ctheta = cos(theta);cpsi = cos(psi);
sphi = sin(phi);stheta = sin(theta);spsi = sin(psi);
DCMbn = [ctheta * cpsi , -cphi * spsi + sphi * stheta * cpsi ,  sphi * spsi + cphi * stheta * cpsi
         ctheta * spsi ,  cphi * cpsi + sphi * stheta * spsi , -sphi * cpsi + cphi * stheta * spsi
             -stheta   ,         sphi * ctheta               ,         cphi * ctheta];

%DCMbn = orth(DCMbn);
end

