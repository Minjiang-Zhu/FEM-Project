function [N,N_g,N_h,N_r] = shape_functions(order)
% The sequence follows gmsh tradition
if order == 1
    N = @(g,h,r) [1-g-h-r; g; h; r;];
    N_g = @(g,h,r) [-1; 1; 0; 0];
    N_h = @(g,h,r) [-1; 0; 1; 0];
    N_r = @(g,h,r) [-1; 0; 0; 1];
elseif order == 2
    N = @(g,h,r) [
        (2*(1-g-h-r)-1)*(1-g-h-r);
        (2*g-1)*g;
        (2*h-1)*h;
        (2*r-1)*r;
        4*(1-g-h-r)*g;
        4*g*h;
        4*(1-g-h-r)*h;
        4*(1-g-h-r)*r;
        4*h*r;
        4*g*r;
    ];
    N_g = @(g,h,r) [
        1-4*(1-g-h-r);
        4*g-1;
        0; 0;
        -4*g + 4*(1-g-h-r);
        4*h;
        -4*h;
        -4*r;
        0; 4*r; 
    ];
    N_h = @(g,h,r) [
        1-4*(1-g-h-r);
        0;
        4*h-1;
        0;
        -4*g;
        4*g;
        -4*h+4*(1-g-h-r);
        -4*r;
        4*r;
        0;
    ];
    N_r = @(g,h,r) [
        1-4*(1-g-h-r);
        0; 0;
        4*r-1;
        -4*g;
        0;
        -4*h;
        4*(1-g-h-r)-4*r;
        4*h;
        4*g;
    ];
end
