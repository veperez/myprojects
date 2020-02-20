function [a,e,i,argp,raan,ta] = get_orb_elem(r_vec,v_vec)
h_vec=cross(r_vec,v_vec)
n_vec=cross([0 0 1],h_vec)

e_vec = ((v^2-mu/r)*r-dot(r_vec,v_vec)*v_vec)/mu
e = norm(e_vec)

Em = v^2/2-mu/r

if e != 1
   a = -mu/(2*Em)
   p = a*(1-e^2)
else
   p = h^2/mu
   a = inf

i = acos(h(3)/h)

raan = acos(n_vec(1)/n)

if n_vec(2)<0
   raan = 360-raan

argp = acos(dot(n_vec,e_vec)/(n*e))

if e(3)<0
   argp = 360-argp

ta = acos(dot(e_vec,r_vec)/(e*r)

if dot(r,v)<0
   ta = 360 - ta
end
