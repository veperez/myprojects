%% Application of Gibb's Method to Preliminary Orbit Determination
% Victor Perez

% Program Description:
%   Calculate v2 given r1,r2, and r3 data, using Gibb's Method

format long

%% Data

r1_vec = [0 0 6378.137];

r2_vec = [0 -4464.696 -5102.509];

r3_vec = [0 5740.323 3189.068];


%% Constants

mu = 3.986e5;

%% Parameters

r1 = norm(r1_vec);
r2 = norm(r2_vec);
r3 = norm(r3_vec);

C12 = cross(r1_vec,r2_vec);
C23 = cross(r2_vec,r3_vec);
C31 = cross(r3_vec,r1_vec);

r1_hat = r1_vec/r1;

D_vec = C12 + C23 + C31;
D = norm(D_vec);

N_vec = r1*C23 + r2*C31 + r3*C12;
N = norm(N_vec);

S_vec = r1_vec*(r2-r3) + r1_vec*(r3-r1) + r3_vec*(r1-r2);


%% Test Parameters
% Dot product between r1_hat and C23 must equal 0
t1 = dot(r1_hat,C23);

if t1 == 0
    v2_vec = sqrt(mu/(N*D))*(cross(D_vec,r2_vec)/r2+S_vec);
    v2 = norm(v2_vec);
end





