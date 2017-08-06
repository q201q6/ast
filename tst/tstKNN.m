function tstKNN(what)
    clc;
    close all;
    clear;
    
    if nargin < 1
        what = '';
    end
    
    if strcmp(what, 'kmeans')
        tstFunc = @myKMeans;
    else
        tstFunc = @myKMeans;
    end

    theta_a = 2 * pi * rand(1,103);
    theta_b = 2 * pi * rand(1, 150);
    theta_c = 2 * pi * rand(1, 244);
    r_a = rand(size(theta_a));
    r_b = 0.6 * rand(size(theta_b));
    r_c = 1.3 * rand(size(theta_c));
    x_a = 1 + r_a .* cos(theta_a);
    y_a = 1 + r_a .* sin(theta_a);
    x_b = 2.8 + r_b .* cos(theta_b);
    y_b = 0.9 + r_b .* sin(theta_b);
    x_c = 1.4 + r_c .* cos(theta_c);
    y_c = 3.7 + r_c .* sin(theta_c);

    figure;
    hold on;
    plot(x_a, y_a, 'r.');
    plot(x_b, y_b, 'g.');
    plot(x_c, y_c, 'b.');
    legend('a', 'b', 'c');
    hold off;
    
    pa = [x_a; y_a]';
    pb = [x_b; y_b]';
    pc = [x_c; y_c]';
    pp = [pa; pb; pc];
    
    [groups cents] = tstFunc(pp, 3);
    figure;
    hold on;
    p1 = find(groups == 1);
    p2 = find(groups == 2);
    p3 = find(groups == 3);
    p3 = find(groups == 3);
    plot(pp(p1,1), pp(p1,2), 'b.');
    plot(pp(p2,1), pp(p2,2), 'g.');
    plot(pp(p3,1), pp(p3,2), 'k.');
    plot(cents(:,1), cents(:,2), 'r*');
    hold off;    
end

