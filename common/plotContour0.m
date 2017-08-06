function plotContour0(theta, h, u, v, FUN, iter, e)
    persistent hcontour;
    
    if nargin < 2
        h = 0;
    end
    if nargin < 3
        u = -1:0.05:1;
    end
    if nargin < 4
        v = u;
    end
    if nargin > 5
        if nargin > 6
            title(sprintf('the %d-th figure, e=%f ', iter, e));
        else
            title(sprintf('the %d-th figure', iter));
        end
    end

    m = length(u);
    n = length(v);
    z = zeros(m, n);
    if nargin < 5
        FUN=@(x1,x2)([ones(size(x1,1),1) x1(:,1) x2(:,1)]);
    end
    
    for i = 1:m
        for j = 1:n
            z(i,j) =  FUN(u(i), v(j)) * theta;
        end
    end
    z = z';
    
    hold on;
    if ~isempty(hcontour) & isvalid(hcontour)
        set(hcontour, 'visible', 'off');
    end
    [tmp hcontour] = contour(u, v, z, [h h]);
    hold off;
end