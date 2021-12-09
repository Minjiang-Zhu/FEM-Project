function stress = ExtractStress(stressvector,k)
s = [
    stressvector(1),stressvector(4),stressvector(6);
    stressvector(4),stressvector(2),stressvector(5);
    stressvector(6),stressvector(5),stressvector(3)];
if k == 4
    % Mises stress
    stress = sqrt(((s(1,1) - s(2,2))^2 + (s(1,1) - s(3,3))^2 + (s(3,3) - s(2,2))^2)/2 ...
        + 3 * ( s(1,2)^2 + s(1,3)^2 + s(2,3)^2 ));
elseif k == 11
    stress = s(1,1);
elseif k == 22
    stress = s(2,2);
elseif k == 33
    stress = s(3,3);
end