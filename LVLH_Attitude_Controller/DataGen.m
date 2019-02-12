%Initial Conditions Generation
clear, clc
%% Parameters
mu = 3.986*(10^5);%km^3/s^2
r_E = 6378;%km
h = 500;%km

%% Orbital Elements
a = 14878;%km
e = 0;
I = deg2rad(15);
RAAN = deg2rad(0);
AP = deg2rad(0);
TA = deg2rad(0);

%% Orbital Elements to Perifocal
p = a*(1-e^2);
r = p/(1+e*cos(TA));
r_pf = [r*cos(TA);r*sin(TA);0];
v_pf = sqrt(mu/p)*[-sin(TA);e+cos(TA);0];

%% Perifocal to ECI

R_RAAN = [cos(RAAN) -sin(RAAN) 0; sin(RAAN) cos(RAAN) 0; 0 0 1];
R_I = [1 0 0; 0 cos(I) -sin(I); 0 sin(I) cos(I)];
R_AP = [cos(AP) -sin(AP) 0; sin(AP) cos(AP) 0; 0 0 1];

r_ECI = R_RAAN*R_I*R_AP*r_pf;
v_ECI = R_RAAN*R_I*R_AP*v_pf;

%% Euler Angles from ECI to LVLH
Eu = [-pi/2 0 pi/2];

%% Initial Angular Velocity in the Body Frame
r_B = angle2dcm(Eu(1),Eu(2),Eu(3))*r_ECI;
v_B = angle2dcm(Eu(1),Eu(2),Eu(3))*v_ECI;
% T = 2*pi*sqrt(a^3/mu);
% q = (2*pi)/T; 
h = cross(r_B,v_B);
w = h/norm(r_B)^2;%((1+e*cos(TA))/p)^2*h;

% open_system('LVLH_Attitude_for_EquatorialOrbit.slx')
% sim('LVLH_Attitude_for_EquatorialOrbit.slx')

