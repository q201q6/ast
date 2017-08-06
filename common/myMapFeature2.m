function [A] = myMapFeature2(X1, X2, deg)
    if nargin < 3
        deg = 2;
    end
    
    m = size(X1, 1);
    A = ones(m, 1);
    
    for i = 1:deg
        for j = 0:i
            A(:,end+1) = (X1.^(i-j)) .* (X2.^(j));
        end
    end
end