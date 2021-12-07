function nodes = IsolateNodes(inputFile,dim,elementNum)
% Function that takes an input .msh file (inputFile), an int (dim) and an 
% int (elementNum) and returns the node numbers for each node for the 
% element of that int.
%
% Function by Travis Zook (tjzook2) - AE 420, Fall 2021

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

% Extract node numbers for element
for j = NodeStart:NodeEnd

    lineStr = lines(j,:);
    lineNum = str2num(lineStr);
    if length(lineNum) == 4 && lineNum(1) == dim && lineNum(2) == elementNum
        
        numNodes = lineNum(4);
        count = 1;
        nodes = zeros(1,numNodes);
        while numNodes > 0

            nodes(count) = str2num(lines(j+count,:));
            count = count + 1;
            numNodes = numNodes - 1;

        end

    end

end

end
