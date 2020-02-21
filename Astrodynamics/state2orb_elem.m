function [a,e,p,i,argp,raan,ta] = get_orb_elem(r_vec,v_vec)
%% Orbital Elements
% Objective: 
%   Calculate orbital elements given position and velocity vectors.

% References:
%   Valladoo, 2007

%% Constants
    mu = 3.986e5;

%% Calculation of Orbital Elements

    r = norm(r_vec);
    v = norm(v_vec);
    
    h_vec = cross(r_vec,v_vec);
    h = norm(h_vec);
    
    n_vec = cross([0 0 1],h_vec);
    n = norm(n_vec);

    e_vec = (1/mu)*cross(v_vec,h_vec)-r_vec/r;
    
    e = norm(e_vec);

    if e ~= 1
        a = mu/((2*mu)/r-v^2);
        p = a*(1-e^2);
    else
        p = h^2/mu;
        a = inf;
    end

    i = acosd(h_vec(3)/h);

    raan = acosd(n_vec(1)/n);

%     if n_vec(2)<0
%        raan = 360-raan;
%     end

    argp = acosd(dot(n_vec,e_vec)/(n*e));

%     if e_vec(3)<0
%        argp = 360-argp;
%     end

    ta = acosd(dot(e_vec,r_vec)/(e*r));

%     if dot(r,v)<0
%        ta = 360 - ta;
%     end
end
