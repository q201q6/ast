function globalVar(X, Y, aLambda, aLearRate, aMaxIter)
    %
    %   定义全局变量
    %   X:  输入数据
    %   Y:  期望输出
    %   aLambda:
    %   aLearnRate:
    %   aMaxIter:
    %
    %
    global lambda;      % 
    global learnRate;	%
    global nElem;       %
    global nData;       %
    global maxIter;     %
    global nIter;       %
    global xs;          %
    global eMin;        %
    global xInput;      %
    global yOutput;     %
    global nPause;      %
    
    lambda = 0;         %
    learnRate = 0.33;   %
    maxIter = 10000;    %
    nElem  = size(X,2); %
    nData = size(X,1);	%
    nIter = 0;          %
    xs = -5:0.1:5;      %
    eMin = 0.0001;      %
    xInput = X;         %
    yOutput = Y;        %
    nPause = 0.1;       %
    
    if nargin >= 3
        lambda = aLambda;
    end
    if nargin >= 4
        learnRate = aLearRate;
    end
    if nargin >= 5
        maxIter = aMaxIter;
    end
end