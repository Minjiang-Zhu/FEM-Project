% Function that takes a .msh input file and returns a Nx4 array of the
% Element mappings, where N = the number of elements in the structure.
%
% Function by Travis Zook (tjzook2) - AE 420, Fall 2021

function map = AssignMap(inputFile)

lines = readlines(inputFile);

% Determine start and end of Elements section
ElementStart = 1;
ElementEnd = 1;
for i = 1:length(lines)
    
    line = lines(i,:);
    tf = strcmp( line,'$Elements' );
    if tf == 1
        ElementStart = i;
    end
    
    tf = strcmp( line,'$EndElements' );
    if tf == 1
        ElementEnd = i;
    end
    
end

% Construct nodal mapping to element
elementMap = [];
for j = ElementStart:ElementEnd
    lineStr = lines(j,:);
    lineNum = str2num(lineStr);
    if length(lineNum) == 5
        elementMap = [ elementMap;lineNum ];
    end
end

% Delete first column
elementMap(:,1) = [];

map = elementMap;
    
end