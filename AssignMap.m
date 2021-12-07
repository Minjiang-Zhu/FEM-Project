function map = AssignMap(inputFile, order)
% Function that takes a .msh input file and returns an array of the
% Element mappings, where N = the number of elements in the structure.
%
% Function by Travis Zook (tjzook2) - AE 420, Fall 2021
% Modified by Matthew Minjinag Zhu on Dec. 16, 2021 to fit mesh file with 
% second-order elements

lines = readlines(inputFile);

% Determine start and end of Elements section
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

if order == 1
    NNodes = 4;
elseif order == 2
    NNodes = 10;
end

NNodes1 = NNodes + 1;
% Construct nodal mapping to element
map = zeros(ElementEnd-ElementStart,NNodes);
count = 0;
for i = ElementStart:ElementEnd
    lineStr = lines(i,:);
    lineNum = str2num(lineStr);
    if size(lineNum,2) == NNodes1
        count = count + 1;
        map(count,:) = lineNum(2:end);
    end
end

map = map(1:count,:);

end
