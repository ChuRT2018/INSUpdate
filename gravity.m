function g = gravity(lat,altitude)
%g = gravity(lat,height)
%global GAMMAa GAMMAb Ra Rb M F;

% h = height;
% clat = cos(lat);
% slat = sin(lat);
% 
% clat = clat * clat;
% slat = slat * slat;
% 
% gamma = (Ra * GAMMAa * clat...
%     + Rb * GAMMAb * slat) /...
%     sqrt(Ra * Ra * clat + ...
%     Rb * Rb * slat);
% 
% g = gamma * (1 - 2 / Ra * (1 + F + M - 2 * F * slat) * h ...
%     + 3 / Ra / Ra * h * h); 
grav = [9.7803267715 0.0052790414 0.0000232718 -0.000003087691089 0.000000004397731 0.000000000000721];
sinB=sin(lat);
sinB2=sinB*sinB;
sinB4=sinB2*sinB2;

g = grav(1) * (1.0 + grav(2) * sinB2+ grav(3) * sinB4) ...
    + (grav(4) + grav(5) * sinB2) * altitude + grav(6) * altitude* altitude;
end

