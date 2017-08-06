function tstGanzhiqi(what)
    %
    %   感知器学习算法
    %
    global learnRate;	%
    global nElem;       %
    global nData;       %
    global maxIter;     %
    global nIter;       %
    global xs;          %
    global eMin;        %
    
    myInit;
    mySignPredict = myGetFunc('mySignPredict');

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
    fprintf('test[GanZhiQi] %s ...\n\n', what);
    
    X = data(:,1:3); %输入
    Y = data(:,4); %输出
    plotLjData(X, Y, [-5 5;-10 15]);
    
    globalVar(X, Y);
    W = rand(nElem, 1); %权值矩阵
    XT = X'; %X的转置
    
	%
    % Y = X * W;
    %
    for nIter = 1 : maxIter
        H = mySignPredict(X * W); %实际输出
        deltaW = (learnRate / nData) * XT * (Y - H);

        if H == Y
            break;
        end
        W = W + deltaW;
        
        fprintf('[%d] ', nIter); fprintf('%f ', W);fprintf('\n');
        plotLine(W);
    end   
    
    plotLine(W);
    fprintf('\n');
    fprintf('NOW W = ');fprintf('%f ', W);fprintf('\n');
    fprintf('    a = ');fprintf('%f ', X*W); fprintf('\n');
    fprintf('    A = ');fprintf('%f ', mySignPredict(X*W)); fprintf('\n');
    fprintf('    Y = ');fprintf('%f ', Y);fprintf('\n');
end
    
    
    
    
    
    
