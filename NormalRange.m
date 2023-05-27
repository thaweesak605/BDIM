function newimg = NormalRange(img, Jmin, Jmax, frac)
    if ~isa(img, 'double' )
        img = double(img);
    end
    Imax = max(img(:));
    Imin = min(img(:));
    if Imin < 0
        img = (img - Imin) / (abs(Imin) + Imax);
%         Imax = 1;
        Imin = 0;
    end
    newimg = img - Imin;
    newimg = newimg ./ max(newimg(:)) * (Jmax - Jmin);
    newimg = newimg + Jmin;
    if frac == 1
        newimg = uint8(newimg);
    end
end