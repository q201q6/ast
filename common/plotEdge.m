function plotEdge(W, e, h)
    persistent hcontour;
    global nPause;
    global nIter;
    global gTstXS;
    global nTstU;
    global nTstV;
    global gTstU;
    global gTstV;
    
    if nargin < 2
        e = -1;
    end
    if nargin < 3
        h = 0;
    end
    
    z = reshape(gTstXS*W, nTstU, nTstV);
    
    hold on;
    
    if e >= 0
        title(sprintf('the %d-th iterator, e=%f ', nIter, e));
    else
        title(sprintf('the %d-th iterator ', nIter));
    end
    
    if ~isempty(hcontour) & isvalid(hcontour)
        set(hcontour, 'visible', 'off');
    end
    
    [tmp hcontour] = contour(gTstU, gTstV, z, [h h]);
    hold off;
    
    if nPause > 0
        pause(nPause);
    end
end

