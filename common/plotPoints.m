function plotPoints(X, Y, type)
    if nargin < 3
        type = 'k';
    end

    hold on;
    
    if strcmp(type, 'line') | strcmp(type, '-') | strcmp(type, '')
        plot(X, Y, 'k');
    elseif strcmp(type, 'point') | strcmp(type, '.')
        plot(X, Y, 'k*');
    else
        plot(X, Y, 'k');
        plot(X, Y, 'k*');
    end
    
    hold off;
end