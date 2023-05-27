function newimg = GrayDouble(img)
    if size(img,3) == 3
        newimg = double(rgb2gray(img));
    else
        newimg = double(img);
    end
end