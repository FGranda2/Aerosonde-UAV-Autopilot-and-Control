%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOAD REQUIRED VARIABLES FOR FIXED-WING SIMULATION
% STATE = [u,alpha,q,theta,h,v,p,r,phi,psi]'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

% Load data from design
load AutoLongData.mat
load AutoLatrData.mat

% Organize matrices
% First linear dynamics
A_final = [A1_long,zeros(5);zeros(5),A1_latr];
B_final = [B1_long,zeros(5,2);zeros(5,2),B1_latr];
C_final = [C1_long,zeros(5);zeros(5),C1_latr];
D_final = zeros(10,4);

% Then LQR Gains
K_deltas = [K_deltas_long,zeros(2);zeros(2),K_deltas_latr];
K_eps = [K_eps_long,zeros(2,2);zeros(2,2),K_eps_latr];
K_lqr = [K_lqr_long,zeros(2,5);zeros(2,5),K_lqr_latr];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODIFY FOR CHANGES IN MANEUVER SEQUENCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For coordinated turn | Specific Radius
Yaw_des =180;  % deg
R = 250;    % m
Ue = 22.3;  % m/s
[Des_roll,Des_rate] = Rtool(R,Ue);

% For maneuvers (Takeoff at 0 secs. Steady-Flight at 400 secs)
% Start of maneuver at 400 secs
Start_time = 400; % sec
% 1.- Steady Flight
x_distance = 1000; % m to go at steady flight
End_forward = x_distance/Ue;
% 2.- Start Turn
Start_turn = Start_time + End_forward; % sec
Turn_time = deg2rad(Yaw_des)/Des_rate;
% 3.- Start descent
Step_timeh = Start_turn + Turn_time; % sec
Initial_h = 2000; % m
Second_h = 1000; % m

