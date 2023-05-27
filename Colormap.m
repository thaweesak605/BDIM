function [Recolored] = Colormap(I,Graph)
    x = 0:255;
    t = 20;
    r(1:t)   = 0.3217 .* x(1:t);
    a =       360.9;
    b =   -0.001182;
    c =      -451.3;
    d =     -0.0134;
    r(t+1:256) = a*exp(b.*x(t+1:end)) + c*exp(d.*x(t+1:end));
    
    t = 74;
    g(1:t)   = 0;
    a0 =        95.3;
    a1 =      -100.4;
    b1 =      -74.29;
    a2 =      -5.162;
    b2 =       27.98;
    a3 =       9.364;
    b3 =       7.937;
    w =      0.01617;
    g(t+1:256) = a0 + a1*cos(x(t+1:256).*w) + b1*sin(x(t+1:256).*w) + ...
                   a2*cos(2*x(t+1:256).*w) + b2*sin(2*x(t+1:256).*w) + ...
                   a3*cos(3*x(t+1:256).*w) + b3*sin(3*x(t+1:256).*w);
    
    a1 =       483.1;
    b1 =     0.01307;
    c1 =      -1.157;
    a2 =       475.8;
    b2 =     0.01808;
    c2 =       1.246;
    a3 =       110.7;
    b3 =     0.07156;
    c3 =      0.9868;
    a4 =       97.37;
    b4 =     0.06933;
    c4 =      -1.933;
    a5 =       5.184;
    b5 =      0.1332;
    c5 =      0.2161;
    b(1:256) = a1*sin(b1*x+c1) + a2*sin(b2*x+c2) + a3*sin(b3*x+c3) + ...
                        a4*sin(b4*x+c4) + a5*sin(b5*x+c5);
    b(b<0) = 0;

    if size(I,3) == 3
        I = rgb2gray(I);
    end
    Recolored = I;
    Recolored(:,:,1) = r(double(I)+1);
    Recolored(:,:,2) = g(double(I)+1);
    Recolored(:,:,3) = b(double(I)+1);

    if Graph == 1
        figure;
        plot(x,r,'LineWidth',1,'Color','red');hold;
        plot(x,g,'LineWidth',1,'Color','green');
        plot(x,b,'LineWidth',1,'Color','blue');
        
        xlim([0 255]); ylim([0 260])
        xlabel('Luminance Level','Interpreter','latex');
        ylabel('Color Intensity','Interpreter','latex');
        legend('Red','Green','Blue','Interpreter','latex','Location','northwest');
        title('Colormap')
    end
end

% x = 0:255;
% t = 20;
% r(1:t)   = 0.3217 .* x(1:t);
% a =       360.9;
% b =   -0.001182;
% c =      -451.3;
% d =     -0.0134;
% r(t+1:256) = a*exp(b.*x(t+1:end)) + c*exp(d.*x(t+1:end));
% 
% t = 74;
% g(1:t)   = 0;
% a0 =        95.3;
% a1 =      -100.4;
% b1 =      -74.29;
% a2 =      -5.162;
% b2 =       27.98;
% a3 =       9.364;
% b3 =       7.937;
% w =      0.01617;
% g(t+1:256) = a0 + a1*cos(x(t+1:256).*w) + b1*sin(x(t+1:256).*w) + ...
%                a2*cos(2*x(t+1:256).*w) + b2*sin(2*x(t+1:256).*w) + ...
%                a3*cos(3*x(t+1:256).*w) + b3*sin(3*x(t+1:256).*w);
% 
% a1 =       483.1;
% b1 =     0.01307;
% c1 =      -1.157;
% a2 =       475.8;
% b2 =     0.01808;
% c2 =       1.246;
% a3 =       110.7;
% b3 =     0.07156;
% c3 =      0.9868;
% a4 =       97.37;
% b4 =     0.06933;
% c4 =      -1.933;
% a5 =       5.184;
% b5 =      0.1332;
% c5 =      0.2161;
% b(1:256) = a1*sin(b1*x+c1) + a2*sin(b2*x+c2) + a3*sin(b3*x+c3) + ...
%                     a4*sin(b4*x+c4) + a5*sin(b5*x+c5);
% figure;
% plot(x,r,'LineWidth',1,'Color','red');hold;
% plot(x,g,'LineWidth',1,'Color','green');
% plot(x,b,'LineWidth',1,'Color','blue');
% 
% xlim([0 255]); ylim([0 260])
% xlabel('Luminance Level','Interpreter','latex');
% ylabel('Color Intensity','Interpreter','latex');
% legend('Red','Green','Blue','Interpreter','latex','Location','northwest');
% title('Colormap')