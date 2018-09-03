function planet = makePlanet(name, m, r, x, y, z, vx, vy, vz, file)
%makePlanet creates a data structure for the basic information of planets
%within a simulated solar system
%   A data structure is created to store the name, mass, radius, force,
%   velocity, position, and color of a plent. Velocity and position are
%   given in their x, y, and z component and stored as a sub-structure. The
%   force is initially empty and later filled in.


%Create sub-structures for the position, force, andd velocity
force = struct('x', [], 'y', [], 'z', []);
velocity = struct('x', vx, 'y', vy, 'z', vz);
position = struct('x', x, 'y', y, 'z', z);

%Store our sub-structures within the mega-structure
planet = struct('Name', name, 'Mass', m, 'Radius', r, 'Force', force,...
    'Velocity', velocity, 'Position', position, 'File', file);