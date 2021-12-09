function Nodes = IsolateNodes(inputFile,dim,entityTag)
% Function that takes an input .msh file (inputFile), an int (dim) and an 
% int (elementNum) and returns the node numbers for each node for the 
% element of that int. entityTag could be a vector
%
% Function by Travis Zook (tjzook2) - AE 420, Fall 2021
% Modified by Matthew Minjiang Zhu on Dec. 7

lines = readlines(inputFile);
L = length(entityTag);

% Determine start and end of Nodes section
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

% Extract node numbers for element
Nodes = [];
for l = 1:L
    
    for j = NodeStart:NodeEnd
        lineStr = lines(j);
        lineNum = str2num(lineStr);
        if length(lineNum) == 4 && lineNum(1) == dim && lineNum(2) == entityTag(l)
            
            numNodes = lineNum(4);
            count = 1;
            nodes = zeros(1,numNodes);
            while numNodes > 0
    
                nodes(count) = str2num(lines(j+count));
                count = count + 1;
                numNodes = numNodes - 1;
    
            end
        end

    end
    Nodes = [Nodes nodes];
end

end