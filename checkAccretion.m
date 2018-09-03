function update = checkAccretion(object)
%checkAccretion checks if any of the planets overlap. If so, the velocity,
%position, radius, and mass are adjusted accordingly
%   object is the array of the data structures for each of the planets.
%   update is the array similar to object however it removes any planets
%   that were taken up and replaces them with the combined object

N = length(object);
update = object;

for i = 1:N-1
    for j = i+1:N
        dx = object(i).Position.x - object(j).Position.x;
        dy = object(i).Position.y - object(j).Position.y;
        dz = object(i).Position.z - object(j).Position.z;
        
        r = sqrt(dx^2 + dy^2 + dz^2);
        
        d = object(i).Radius + object(j).Radius;
        
        if r <= d
            update(i).Mass = object(i).Mass + object(j).Mass;
            update(i).Radius = nthroot((object(i).Radius)^3 + (object(j).Radius)^3,3);
            
            update(i).Position.x = (object(i).Position.x + object(j). Position.x)/2;
            update(i).Position.y = (object(i).Position.y + object(j). Position.y)/2;
            update(i).Position.z = (object(i).Position.z + object(j). Position.z)/2;
            
            update(i).Velocity.x = (object(i).Mass * object(i).Velocity.x...
                +object(j).Mass * object(j).Velocity.x)/update(i).Mass;
            update(i).Velocity.y = (object(i).Mass * object(i).Velocity.y...
                +object(j).Mass * object(j).Velocity.y)/update(i).Mass;
            update(i).Velocity.z = (object(i).Mass * object(i).Velocity.z...
                +object(j).Mass * object(j).Velocity.z)/update(i).Mass;
            
            update(j) = [];
            
            N = N - 1;
        end
    end
end

end