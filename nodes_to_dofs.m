function Elmt_dof = nodes_to_dofs(NodesInElmt)
% Elmt_dof is the dof of coordinates in the sequence of [x1,y1,z1,x2,y2,z2...]
% Created by Matthew Minjiang Zhu
n = length(NodesInElmt); % number of nodes is given by the size of the node list
Elmt_dof = zeros(3*n, 1);
z = 3*NodesInElmt;
Elmt_dof(1:3:end) = z - 2;
Elmt_dof(2:3:end) = z - 1;
Elmt_dof(3:3:end) = z;
end