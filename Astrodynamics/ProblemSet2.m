%% Problem Set 2
% Victor Perez

clear,clc
%% Data

r1_vec = [0 0 6378.137];

r2_vec = [0 -4464.696 -5102.509];

r3_vec = [0 5740.323 3189.068];


format long
%% Gibb's Preliminary Orbit Determination

[v2_vec,v2] = GibbsPOD(r1_vec,r2_vec,r3_vec);

%% Determine Orbital Elements from Position and Velocity

[a,e,p,i,argp,raan,ta] = state2orb_elem(r2_vec,v2_vec);

%% Orbit Propagation
% Ozan Kilic (2020). Runge-Kutta 4th Order Orbit Simulation 
% (https://www.mathworks.com/matlabcentral/fileexchange/70076-runge-kutta-4th-order-orbit-simulation),
% MATLAB Central File Exchange. Retrieved February 21, 2020.

X = [r2_vec';v2_vec']*1e3;
h = 30;                  % Step Size (sec)
steps = 300;              % Number of Steps
[X_RK] = RK_4(X,h,steps); % Orbit in ECI (PV)

r_vec = X_RK(1:3,:)/1e3;
v_vec = X_RK(4:6,:)/1e3;

plot3(r_vec(1,:),r_vec(2,:),r_vec(3,:),'LineWidth',2.0)
xlabel('X(km)');ylabel('Y(km)');zlabel('Z(km)')
xlim([min(r_vec(1,:))-500 max(r_vec(1,:))+500])
ylim([min(r_vec(2,:))-500 max(r_vec(2,:))+500])
ylim([min(r_vec(3,:))-500 max(r_vec(3,:))+500])
grid on
hold on
r1 = norm(r1_vec); r2 = norm(r2_vec); r3 = norm(r3_vec);
l = r1_vec/r1; m = r2_vec/r2; n = r3_vec/r3;
lv =(0:1:r1)'*l; mv =(0:1:r2)'*m;nv =(0:1:r3)'*n;
plot3(lv(:,1),lv(:,2),lv(:,3),'.r');
plot3(mv(:,1),mv(:,2),mv(:,3),'.g');
plot3(nv(:,1),nv(:,2),nv(:,3),'.b');
legend('Orbit','R1','R2','R3');

