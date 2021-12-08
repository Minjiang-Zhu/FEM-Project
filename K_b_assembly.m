function [K_g, bf] = K_b_assembly(MeshFile, Nodes, properties, order, Gauss)
% Script for assembling the global stiffness matrix and the body force
% Created by Matthew Minjiang Zhu 

% Initiate the global stiffness matrix K_g and the body force vector b
NNodes = length(Nodes);
K_g = sparse(NNodes*3,NNodes*3);
bf = zeros(NNodes*3,1);

% Obtain the shape functions and their derivatives
[N,N_g,N_h,N_r] = shape_functions(order);
N_ = @(g,h,r) [N_g(g,h,r),N_h(g,h,r),N_r(g,h,r)]';

% The Jacobian matrix.
J = @(xyz,g,h,r) N_(g,h,r)*xyz;

% Obtain Gauss quadrature points and weights
[gG,hG,rG,wt] = TetQuadDat(Gauss);

% Initialize the 6*3n strain-displacement matrix B
NNodesInElmt = length(N(0,0,0));
Be = zeros(6,3*NNodesInElmt);

NDomains = size(properties,2);
dim = 3;
for d = 1:NDomains
    E      = properties(1,d);
    nu     = properties(2,d);
    alphaT = properties(3,d)*(properties(5,d) - properties(4,d));
    strain_th = alphaT * [ones(3,1); zeros(3,1)];

    % Define Elastic constant matrix such that stress = E_m * strain
    E_m = Obtian_E_m(E,nu);
    E_th = E_m*strain_th;
    elements = ElementsInDomain(MeshFile, order, dim, d);
    for i = 1:length(elements)
        NodesInElmt = elements(i, :); % extract node serial numbers
        XYZ = Nodes(NodesInElmt,:);

        bfe = zeros(3*NNodesInElmt,1);  % Initialized elemental body force 
        ke = zeros(3*NNodesInElmt); % Initialize elemental stiffness matrix 
        Je = @(g,h,r) J(XYZ,g,h,r); % The Jacobian matrix for this element

        % Apply Gauss quadrature
        for j = 1:length(wt)    % for each quadrature point
            % Calculate the 3 by n B matrix
            Jacobian = Je(gG(j),hG(j),rG(j));
            determinant = det(Jacobian);
            B = Jacobian \ N_(gG(j),hG(j),rG(j));

            % Expand 3 by n B matrix to 6 by 3*n Be matrix
            Be(1,1:3:end) = B(1,:);
            Be(4,2:3:end) = B(1,:);
            Be(6,3:3:end) = B(1,:);
            Be(2,2:3:end) = B(2,:);
            Be(4,1:3:end) = B(2,:);
            Be(5,3:3:end) = B(2,:);
            Be(3,3:3:end) = B(3,:);
            Be(5,2:3:end) = B(3,:);
            Be(6,1:3:end) = B(3,:);

            ke = ke + wt(j)*Be'*E_m*Be*determinant;
            bfe = bfe + wt(j)*Be'*E_th*determinant;
        end
    
        Elmt_dof = nodes_to_dofs(NodesInElmt);
    
        K_g(Elmt_dof, Elmt_dof) = K_g(Elmt_dof, Elmt_dof) + ke;
        bf(Elmt_dof) = bf(Elmt_dof) + bfe;
    end
end

end