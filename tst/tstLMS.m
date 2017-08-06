function tstLMS(what, track)
    %
    %   LMS学习算法
    %
    %   tstLMS(what, track)
    %
    global learnRate;
    global nElem;
    global nData;
    global maxIter;
    global nIter;
    global xs;
    global eMin;
    global gTstXS;
    
    myInit;

    %数据
    data0=[ ... %  DATA0
        1 3 3 1;
        1 4 3 1; 
        1 1 1 -1;];
    dataXOR=[ ... % XOR
        1 0 0 -1;
        1 0 1 1;
        1 1 0 1;
        1 1 1 -1];
    dataAND = [ ... % AND
        1 0 0 -1; 
        1 0 1 -1;
        1 1 0 -1;
        1 1 1 1];
    dataOR = [ ... % OR
        1 0 0 -1; 
        1 0 1 1;
        1 1 0 1;
        1 1 1 1];
    
    if nargin < 1
        what = 'and';
    end
    if nargin < 2
        track = 0;
    end
    
    if strcmp(what, 'data0')
        data = data0;
    elseif strcmp(what, 'and')
        data = dataAND;
    elseif strcmp(what, 'or')
        data = dataOR;
    elseif strcmp(what, 'xor')
        data =dataXOR;
    else
        what = 'or';
        data = dataOR;
    end
    fprintf('test[LMS] %s ...\n\n', what);
    
    X0 = data(:,1:3);   %输入
    Y = data(:,4);      %输出
    
    X = myMapFeature2(X0(:,2), X0(:,3));	%输入特征
    globalVar(X, Y);
    globalTestVar(@myMapFeature2, -0.5:0.1:1.5);
    W = rand(nElem, 1);
    XT = X';
    plotLjData(X0, Y, xs);

    %
    %   Y = X * W
    %
    for nIter = 1 : maxIter
        e = Y - X * W;
        norm_e = norm(e);
        if norm_e < eMin
            break;
        end
        W = W + (learnRate / nData) * XT * e;
     
        if track >= 0.5
            fprintf('[%d] norm_e=%f \n', nIter, norm_e);plotEdge(W, norm_e);
        end
    end
    
    plotEdge(W, norm_e);
    fprintf('\n');
    fprintf('NOW W = ');fprintf('%f ', W); fprintf('\n');
    fprintf('    A = ');fprintf('%f ', X*W); fprintf('\n');
    fprintf('    Y = ');fprintf('%f ', Y); fprintf('\n');
end
    
    
    
    
    
    
    
    
    
    
    
    
    
