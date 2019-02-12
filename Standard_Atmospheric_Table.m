clear,clc
% Victor Perez, Aer E 161
% Project 1
% Objective:
% Calculates standard atmosphere values for troposphere and stratosphere (0 to % 47 km)
% Plots ( Temperature vs. Geopotential Altitude, Pressure vs. Geopotential     % Altitude,
% Density vs. Geopotential Altitude)
 
 
%====================== Variables and Initial Conditions =======================
 
T_sl = 288.16; % Temperature at sea level in Kelvin
d_sl = 1.225; % Density at sea level in kg/m^3
p_sl = 1.01325*10^5; % Pressure at sea level in N/m^2
g_0 = 9.80065;% standard value for gravity in m/s^2
R = 287; % Gas Constant in J/(kg*K)
a_t = -6.5*10^-3; % lapse rate for the troposhere in K/m
a_s = 3*10^-3; % lapse rate for the stratosphere in K/m
r_E = 6371.0008; % Earth's radius in km
 
%=================================== Arrays ===================================
 
h = 0:47; % Geopotential Altitude in km
% Pre-allocated Vectors
T = zeros(1,48); % Temperature in Kelvin
p = zeros(1,48); % Pressure in N/m^2
d = zeros(1,48); % Density in kg/m^3
 
%================================ Calculations ================================
 
h_G = (h.*r_E)./(r_E-h); % Formula for Geometric Altitude
 
for i = 1:48
    if h(i) <= 11 % Gradient Layer 1
       % Formulas for Temperature, Pressure, and Density for Geopotential
       % Altitude (1-11km)
        T(i) = T_sl + (a_t.*(h(i)*1000));
        p(i) = p_sl .* ((T(i)/T_sl).^(-g_0/(a_t*R)));
        d(i) = d_sl .* ((T(i)/T_sl).^(((-g_0/(a_t*R)) - 1)));
    
    elseif h(i) >= 11 && h(i) <= 25 %Isothermal Layer
       % Formulas for Temperature, Pressure, and Density for Geopotential
       % Altitude (11-25km) 
        T(i) = T(12);
        p(i) = p(12) .* exp((-g_0/(R.*T(i))).*((h(i)-h(12))*1000));
        d(i) = d(12) .* exp((-g_0/(R.*T(i))).*((h(i)-h(12))*1000));
      
    else % Gradient Layer 2
       % Formulas for Temperature, Pressure, and Density for Geopotential
       % Altitude (25-47km)
        T(i) = T(26) + a_s.*((h(i) - h(26))*1000);
        p(i) = p(26) .* ((T(i)/T(26)).^(-g_0/(a_s*R)));
        d(i) = d(26) .* ((T(i)/T(26)).^(((-g_0/(a_s*R)) - 1)));
    end
end
 
%===================================== Table ==================================
 
fprintf('GEOPOTENTIAL ALTITUDE (km)   GEOMETRIC ALTITUDE (km)   TEMPERATURE (K)      PRESSURE (N/m^2)      DENSITY (hg/m^3)\n')
mat = [h ; h_G ; T ; p ; d]; % Creates a 5 x 48 matrix with the calculated values
fprintf('%10.f%32.5f%23.5f%23.10f%20.10f\n', mat)% Prints values as a table with % 5 columns 
%=================================== Plots ====================================
 
figure(1) %Graph for Temperature
plot(T, h) 
title({'Standard Atmosphere 0-47km:'; 'Geopotential Altitude vs. Temperature'})
xlabel('Temperature (K)')
ylabel('Geopotential Altitude (km)')
grid
 
figure(2) %Graph for Pressure
plot(p, h)
title({'Standard Atmosphere 0-47km:'; 'Geopotential Altitude vs. Pressure'})
xlabel('Pressure (N/m^2)')
ylabel('Geopotential Altitude (km)')
grid
 
figure(3) %Graph for Density
plot(d, h)
title({'Standard Atmosphere 0-47km:'; 'Geopotential Altitude vs. Density'})
xlabel('Density (kg/m^3)')
ylabel('Geopotential Altitude (km)')
grid
