function CheckDiameter = Diameter(img)
    obj = imread(img);
    lambda = 15/1848;
    row = -1;
    startcol = -1;
    finishcol = -1;
    blue = obj(:,:,3);
    bw = imbinarize(blue);
    se = strel('disk',5);
    bw = imopen(bw,se);
    [rows,cols] = size(bw);
    for j = 1:cols
        for i = 1:rows
            if bw(i,j) == 0
                row = i;
                startcol = j;
                break;
            end
        end
        if (startcol ~= -1)
            break;
        end
    end       
    for j = startcol:cols
        if bw(row,j) == 1
            finishcol = j;
            break;
        elseif j == cols
            finishcol = cols; 
        end
    end  
    CheckDiameter = (finishcol-startcol)*lambda;
end