function OnSurf = ifTriangleOnSurf(NodesTag,TwoDElementsOnSurf)
OnSurf = 0;
count = 0;
NNodes = length(NodesTag);
for i = 1:NNodes
    if size(find(TwoDElementsOnSurf == NodesTag(i)),1) ~= 0
        count = count + 1;
    end
end

if count == 3
    OnSurf = 1;
end

end