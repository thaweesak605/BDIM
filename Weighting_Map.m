function [w,map] = Weighting_Map()
    min_f  = -20;
	max_f  =  20;
	step_f = 1;
	u      = min_f:step_f:max_f;
    U      = u;
    for i = 1:(length(u) - 1)
        U = cat(1,U,u);
    end
	sigma = 2;
    u     = U;
    v     = U';
	f     = sqrt(u .* u + v .* v);
	w     = 2 .* pi .* f ./ 60;
	Sw    = 1.5 .* exp(-sigma .^2 .*w .^ 2 ./ 2)-exp(-2 .* sigma .^ 2 .* w .^2 ./ 2);
	% Modification in High frequency
	sita  = atan(v./(u+eps));
	bita  = 8;
	f0    = 11.13;
	w0    = 2 .* pi .* f0 ./ 60;
	Ow    = (1 + exp(bita .* (w - w0)) .* (cos(2 .* sita)) .^ 4) ./ (1 + exp(bita .* (w - w0)));
	% Compute final response
	map   = Sw .* Ow;
    w     = fsamp2(map);
end