function OnSurf = ifElmtOnSurf(Element,ElementsOnSurf)

OnSurf = 0;
NNodes = length(Element);
count = 0;
for i = 1:NNodes
    if size(find(ElementsOnSurf == Element(i)),1) ~= 0
        count = count + 1;
    end
end
    
if (NNodes == 4 && count >= 3) || (NNodes == 10 && count >= 6)
    OnSurf = 1;
end

end 