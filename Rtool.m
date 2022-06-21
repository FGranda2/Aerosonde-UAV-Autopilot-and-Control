function [angle_deg,rate] = Rtool(R,Ue)
% Function to compute roll angle and yaw rate for R
g = 9.81;
syms phi
eqn1 = R == Ue^2 / (g*tan(phi));
angle = double(solve(eqn1,phi));
angle_deg = rad2deg(angle);
% RATE
rate = g*tan(angle)/Ue;
end

