function globalTestVar(MAPFUN, u, v)
    global gTstXS;
    global nTstU;
    global nTstV;
    global gTstU;
    global gTstV;

    if nargin < 1
        MAPFUN = @(x1,x2)([ones(size(x1,1),1) x1(:,1) x2(:,1)]);
    end
    if nargin < 2
        u = -1:0.05:1;
    end
    if nargin < 3
        v = u;
    end
    
    nTstU = length(u);
    nTstV = length(v);
    
    gTstU = u;
    gTstV = v;
    tmp = MAPFUN([0], [0]);
    gTstXS = zeros(nTstU*nTstV, length(tmp));
    
    k = 1;
    for i = 1 : nTstU
        for j = 1 : nTstV
            gTstXS(k,:) = MAPFUN(u(i), v(j));
            k = k + 1;
        end
    end
    
end