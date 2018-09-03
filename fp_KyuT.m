%Solar System
%Simulation of a fabricated solar system
%Tiffany Kyu, UID: 404283852

%Clears command window, workspace, and closes open figures
clear all; close all; clc;

%Gravitational constant
G=1;

%%Initializing data for each planet in solar system for different situations

%Normal orbitting solar system
object(1) = makePlanet('Sun', 1000000, 200, 0,0,0, 0,0,0, 'Sun.jpg');
object(2) = makePlanet('Mercury', 200, 20, 300,0,0, 0,sqrt(G*object(1).Mass/300),0, 'Mercury.jpg');
object(3) = makePlanet('Venus', 4000, 50, 500,0,0, 0,sqrt(G*object(1).Mass/500),0, 'Venus.jpg');
object(4) = makePlanet('Earth', 5000, 60, 800,0,0, 0,sqrt(G*object(1).Mass/800),0, 'Earth.jpg');
object(5) = makePlanet('Mars', 400, 24, 1200,0,0, 0,sqrt(G*object(1).Mass/1200),0,'Mars.jpg');

%Accretion example 1
% object(1) = makePlanet('Sun', 10000,  100, 0,0,0, 0,0,0, 'Sun.jpg');
% object(2) = makePlanet('Mercury', 200, 5, 135,-150,0, 3,5,0, 'Mercury.jpg');
% object(3) = makePlanet('Venus', 4000, 25, 200,300,0, -5,2,0, 'Venus.jpg');
% object(4) = makePlanet('Earth', 5000, 30, 250,230,0, 0,5,0, 'Earth.jpg');
% object(5) = makePlanet('Mars', 400, 24, 300,0,0, 0,10,0,'Mars.jpg');

%Accretion example 2
% object(1) = makePlanet('Sun', 1000000,  200, 0,0,0, 0,0,0, 'Sun.jpg');
% object(2) = makePlanet('Mercury', 200, 20, 0,0,500, 0,-sqrt(G*object(1).Mass/500),0, 'Mercury.jpg');
% object(3) = makePlanet('Venus', 4000, 50, 0,0,-500, 0,-sqrt(G*object(1).Mass/500),0, 'Venus.jpg');
% object(4) = makePlanet('Earth', 5000, 60, 500,0,0, 0,sqrt(G*object(1).Mass/500),0, 'Earth.jpg');
% object(5) = makePlanet('Mars', 400, 24, -500,0,0, 0,sqrt(G*object(1).Mass/500),0,'Mars.jpg');

%Gravity assist
% object(1) = makePlanet('Sun', 10000,  100, 0,0,0, 0,0,0, 'Sun.jpg');
% object(2) = makePlanet('Mercury', 200, 5, 135,0,0, 0,9,0, 'Mercury.jpg');
% object(3) = makePlanet('Venus', 4000, 25, 250,0,0, 0,7.5,0, 'Venus.jpg');

%Verification test
% object(1) = makePlanet('Sun', 10000,  100, -500,0,0, 0,0,0, 'Sun.jpg');
% object(2) = makePlanet('Mercury', 10000, 100, 500,0,0, 0,9,0, 'Mercury.jpg');

%Define constants (time variables and gravitational)
dt = .05;
tfinal = 200;
nt = ceil(tfinal/dt);

%Video formatting
vidhandle = VideoWriter('Test', 'MPEG-4');
vidhandle.FrameRate = 30;
vidhandle.Quality = 100;
open(vidhandle);

%Sets up the figure window to capture frames
figure;
[xs,ys,zs] = sphere; %Set up standard sphere

%Update the new position of planets
for k = 1:nt
    
    %Adds comet simualtion; uncomment to add comet to normal orbitting
    %solar system
%     if k == 150
%        object(6) = makePlanet('Comet', 150, 20, -1200,0,0, 0,20,0, 'Comet.jpg'); 
%     end
    
    N = length(object); %Number of planets in system
    
    for i = 1:N
        %Plots each sphere to figure
        surf(xs*object(i).Radius+object(i).Position.x, ys*object(i).Radius+...
            object(i).Position.y, zs*object(i).Radius+object(i).Position.z,...
            'EdgeColor', 'none');
        
        set(gca,'Color', 'black'); %Black background
        
     
        
        %Wrap images around spheres
        I = imread(object(i).File);
        warp(xs*object(i).Radius+object(i).Position.x, ys*object(i).Radius+...
            object(i).Position.y, zs*object(i).Radius+object(i).Position.z,I);
        hold on;
    end
    
    hold off;
    
    %Graph formating
    axis equal;
    axis( [-1200 1200 -1200 1200 -1200 1200]);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    
    %Update kinematics of planets
    object = updatePlanet(N, dt, G, object);
    
    %Accretion function; uncomment if in use
    %object = checkAccretion(object);
    
    writeVideo(vidhandle,getframe);
end

close(vidhandle);