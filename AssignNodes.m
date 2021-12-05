% Function that takes a .msh input file and returns a Nx3 array of the
% nodal coordinates, where N = the number of nodes in the structure.
%
% Function by Travis Zook (tjzook2) - AE 420, Fall 2021

function nodes = AssignNodes(inputFile)

lines = readlines(inputFile);

% Determine start and end of Nodes section
NodeStart = 1;
NodeEnd = 1;
for i = 1:length(lines)
    
    line = lines(i,:);
    tf = strcmp( line,'$Nodes' );
    if tf == 1
        NodeStart = i;
    end
    
    tf = strcmp( line,'$EndNodes' );
    if tf == 1
        NodeEnd = i;
    end
    
end

% Construct coordinate mapping to node
nodeCoords = [];
for j = NodeStart:NodeEnd
    lineStr = lines(j,:);
    lineNum = str2num(lineStr);
    if length(lineNum) == 3
        nodeCoords = [ nodeCoords;lineNum ];
    end
end

nodes = nodeCoords;
    
end