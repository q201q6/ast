function plotLine(A)
    global xs;
    global nIter;
    global nPause;
    
    persistent hline;
    if length(A) == 3
        c = A(3);
        if c ~= 0
            a = - A(1) / c;
            b = - A(2) / c;
            Y = a + b * xs;
            hold on;
            title(sprintf('the %d-th line', nIter));
            if ~isempty(hline) & isvalid(hline)
                set(hline, 'visible', 'off');
            end
            hline = plot(xs, Y, 'b');
            hold off;
            if nPause > 0
                pause(nPause);
            end
        end
    end
end