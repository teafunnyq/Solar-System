function object = updatePlanet(N, dt, G, object)
%updatePlanet determines the force exerted on each planet and updates the
%acceleration, velocity, and position for each time step.
%   object is the array of the data structures for each of the planets. It
%   functions as both an input and output as we update the information and
%   then retunr it. N is the length of object. dt is the time step. G is
%   the gravitational constant.

%Loop that goes through each planet
for i = 1:N
    Fx = 0; Fy = 0; Fz = 0; %Initial force of each planet
    for j = 1:N
        if j~=i %Calculates the force from every planet
            dx = object(i).Position.x - object(j).Position.x;
            dy = object(i).Position.y - object(j).Position.y;
            dz = object(i).Position.z - object(j).Position.z;
            
            r = sqrt(dx^2 + dy^2 + dz^2);%Distance between two planets
            
            f = -G * object(i).Mass * object(j).Mass / r^2; %Force
            
            theta = atan2(dy,dx);
            phi = atan2(dz, sqrt(dx^2+dy^2));
            
            Fx = Fx + f * cos(phi) * cos(theta);
            Fy = Fy + f * cos(phi) * sin(theta);
            Fz = Fz + f * sin(phi);
        end
    end
    object(i).Force.x = Fx;
    object(i).Force.y = Fy;
    object(i).Force.z = Fz;
end

for i = 1:N
    ax = object(i).Force.x / object(i).Mass;
    ay = object(i).Force.y / object(i).Mass;
    az = object(i).Force.z / object(i).Mass;
    
    vx = ax * dt + object(i).Velocity.x;
    vy = ay * dt + object(i).Velocity.y;
    vz = az * dt + object(i).Velocity.z;
    
    x = vx * dt + object(i).Position.x;
    y = vy * dt + object(i).Position.y;
    z = vz * dt + object(i).Position.z;
    
    object(i).Velocity.x = vx; %If we placed it in arrays instead, it might speed it up
    object(i).Velocity.y = vy;
    object(i).Velocity.z = vz;
    
    object(i).Position.x = x;
    object(i).Position.y = y;
    object(i).Position.z = z;
end

end
