function [c_bar,AR,eO,K,Re] = Aircraft_Wing(b,S,rho,Cd_0)
% AerE 261
%Aircraft Wing
%Purpose: Calculate Values for wing of aircraft
%given wingspan and planform area.

format long

c_average = S/b;
 
AR = b^2/S

eO = 1.78*(1 - 0.045*AR^0.68) - 0.64

K = 1/(pi*eO*AR)

E_m = 1/(2*sqrt(K*Cd_0))

%Re = (rho*v*c_average)/mu;


end

