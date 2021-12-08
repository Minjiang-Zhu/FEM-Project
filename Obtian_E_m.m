function E_m = Obtian_E_m(E,nu)
E_m = diag((1-2*nu)/2*ones(6,1));
E_m(1:3,1:3) = nu;
for i = 1:3
    E_m(i,i) = 1 - nu;
end
E_m = E_m * E / (1 + nu) / (1 - 2*nu);
end

