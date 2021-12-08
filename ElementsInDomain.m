function map = ElementsInDomain(MeshFile, order, dim, domainTag)
% Function that takes a .msh input file and returns an array of the
% Element mappings
%
% Function by Matthew Minjinag Zhu on Dec. 16

lines = readlines(MeshFile);

% Determine the start and end of Elements section
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

% Construct nodal mapping to element
for i = ElementStart:ElementEnd
    lineNum = str2num(lines(i));
    if length(lineNum) == 4 && lineNum(1) == dim && lineNum(2) == domainTag
        NElements = lineNum(4);
        map = zeros(NElements,NNodes+1);
        for j = 1:NElements
            map(j,:) = str2num(lines(i+j));
        end
    end
end

map = map(:,2:end);

end