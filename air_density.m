function [rho] = air_density(h_ft)

% Objective:
% Calculates the value for air density in slugs/ft^3 given a height in ft
 
 
%====================== Variables and Initial Conditions =======================
 
T_sl = 288.16; % Temperature at sea level in Kelvin
d_sl = 1.225; % Density at sea level in kg/m^3
g_0 = 9.80065;% standard value for gravity in m/s^2
R = 287; % Gas Constant in J/(kg*K)
a_t = -6.5*10^-3; % lapse rate for the troposhere in K/m
a_s = 3*10^-3; % lapse rate for the stratosphere in K/m
h = h_ft*0.0003048;

 
%================================ Calculations ================================
 
if h <= 11 % Gradient Layer 1
       % Formulas for Temperature, Pressure, and Density for Geopotential
       % Altitude (1-11km)
        T = T_sl + (a_t.*(h*1000));
        d = d_sl .* ((T/T_sl).^(((-g_0/(a_t*R)) - 1)));
    
elseif h >= 11 && h <= 25 %Isothermal Layer
       % Formulas for Temperature, Pressure, and Density for Geopotential
       % Altitude (11-25km) 
        T = 216.66;
        d = 0.3641687828 .* exp((-g_0/(R.*T)).*((h-11)*1000));
      
else % Gradient Layer 2
       % Formulas for Temperature, Pressure, and Density for Geopotential
       % Altitude (25-47km)
        T = 216.66 + a_s.*((h - 25)*1000);
        d = 0.0338094405 .* ((T/216.66).^(((-g_0/(a_s*R)) - 1)));
end

rho = d*0.0019403203;
end