function [InvertDIMTE,DIMTE] = Thermal_DIMTE(img,kernel,Condition)
% Condition = normalize : Rescale the thermal metric to [0,1]
% Kernel                : Size of a tile
% k = 3;
% Condition = 'normalized';
    k = kernel;
    S = round(k/2) - 1;
    img = padarray(img,[S S],'symmetric');
    [~,~,z] = size(img);
    if z == 3
        img = rgb2gray(img);
    end
    I = GrayDouble(img);
    Local_Block = im2col(I,[k k]);
    DIMTE  = zeros(1,size(Local_Block,2));  
    parfor i = 1:size(Local_Block,2)
        Current_I = sort(Local_Block(:,i));
        Current_P = Current_I/sum(Current_I(:));
        Current_C = cumsum(Current_P);
        Pmin = min(Current_P(:));
        Pmax = max(Current_P(:));
        Imin = min(Current_I(:));
        Imax = max(Current_I(:));
        P_Dark = Current_C(1:end-1);
        P_Bright = 1 - P_Dark;
        P_Entropy = P_Dark .* log10(P_Dark ./ P_Bright);
        T = find(P_Entropy==min(P_Entropy(:)), 1);
        if isempty(T) == 0
            DIMTE(i)  = (Pmin(1) / (Pmax(1) + Pmin(1))) * ((Imin(1) / (Imax(1) + Imax(1))) ^ 2);
        end
    end
    DIMTE  = reshape(DIMTE,size(img,1)-k+1,size(img,2)-k+1);
    InvertDIMTE = 1 ./ (1 + DIMTE);
    if Condition == 'normalized'
        %% Normalization
        DIMTE  = NormalRange(DIMTE,0,1,0);
        InvertDIMTE  = NormalRange(InvertDIMTE,0,1,0);
    end
%     InvertDIMTE = mean(InvertDIMTE(:));
%     DIMTE = mean(DIMTE(:));
end