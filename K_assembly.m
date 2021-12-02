function Kg = K_assembly(NElmt, NNode, X, Y, E, nu, nodemap, plane, Gauss)
% Script for assembling the global stiffness matrix

% Define E matrix such that stress = E_m * strain
E_m = Obtian_E_m(E,nu,plane);

% initialize global stiffness matrix (alternative function: "Kg = sparse(ndof, ndof)")
Kg = zeros(2*NNode, 2*NNode); 
                        
% Obtain the shape functions and their derivatives
[~,N_xi,N_eta] = shape_functions();
N_ = @(xi,eta) [N_xi(eta), N_eta(xi)]';

% The Jacobian matrix. It is a function of positions of nodal points,xi,eta 
J = @(xe,ye,xi,eta) N_(xi,eta)*[xe,ye];

% Obtain Gauss quadrature points and weights
[Gauss_xi, Gauss_eta, Weights] = Gauss_quadrature(Gauss);

% Initialize the 3*8 strain-displacement matrix B
Be = zeros(3,8);

% Assembly Kg
for i = 1:NElmt
    Elmt_nodes = nodemap(i, :); % extract node serial numbers from element i
    Xe = X(Elmt_nodes); % obtain x-coordinates of element i's nodes
    Ye = Y(Elmt_nodes); % obtain y-coordinates of element i's nodes
    
    % obtain element stiffness matrix
    ke = zeros(8);
    Je = @(xi,eta) J(Xe,Ye,xi,eta);
    
    % Apply Gauss quadrature
    for j = 1:Gauss
        % Assemble the 3*8 strain-displacement matrix Be
        B = Je(Gauss_xi(j),Gauss_eta(j))\N_(Gauss_xi(j),Gauss_eta(j));
        Be(1,1:2:7) = B(1,:); Be(3,2:2:8) = B(1,:); 
        Be(2,2:2:8) = B(2,:); Be(3,1:2:7) = B(2,:); 
        ke = ke + Weights(j)*Be'*E_m*Be*det(Je(Gauss_xi(j),Gauss_eta(j)));
    end
    
    Elmt_dof = nodes_to_dofs(Elmt_nodes);
    
    Kg(Elmt_dof, Elmt_dof) = Kg(Elmt_dof, Elmt_dof) + ke;
end
end