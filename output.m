% the output plot of the code
% by Yong Ye , Dec.5th.2021
figure;
ne=length(elem(1,:));  %number of elements
nnel=12;  %number of nodes per element
% Initialization of the matrices
p1=zeros(nnel,nel);
p2=zeros(nnel,nel);
p3=zeros(nnel,nel);
profile=zeros(nnel,nel);
node=zeros(nnel);

for iel=1:ne
   for i=1:nnel
      node(i)=elem(i,iel); %extract coonected node for (iel)-th element
      p1(i,iel)=noodmap(1,node(i)); %extract x value of the node
      p2(i,iel)=noodmap(2,node(i)); %extract y value of the node
      p3(i,iel)=noodmap(3,node(i)); %extract z value of the node
   end
end
% plot the FEM mesh and profile of the component
surf(p1,p2,p3);
colorbar;
daspect([1 1 1]);

hold on
title("Thermal Stress in a Layered Plate");
xlabel("\times 10^{-3}m");
ylabel("\times 10^{-3}m");
zlabel("\times 10^{-3}m");

