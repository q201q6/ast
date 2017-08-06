function tstBP1(what)
    %
    %       一个隐藏层的bp神经网络
    %
    %       输入层L1   隐藏层L2    输出层L3
    %       n1          n2          n3      节点个数
    %                   f2          f3      激励函数
    %       w1          w2                  权重
    %       b1          b2                  阈值
    %
    %       inputL2 = w1*L1 + b1    outputL2 = f2(inputL2)
    %       inputL3 = w2*L2 + b2    outputL3 = f3(inputL3)
    %
    
    global nIter;
    global maxIter;
    global nElem;
    global nData;
    global learnRate;
    global eMin;
    
    myInit;
    
    if nargin < 1
        what = 'sin1';
    end
    
    if strcmp(what, 'xor')
        % y = xor(x1,x2)
        netfunc = @netFuncXor;
        okX = [ 0 0 1 1; 0 1 0 1];
        netInput  = okX;                            % 网络的训练样本
    else
        % y = 1 + sin(x*K*pi/4)
        netfunc = @netFuncSin1;
        okX = -2:0.05:2;
        netInput  = [-2 : 0.4 : 2];                 % 网络的训练样本
    end
    
    netOutput = netfunc(netInput);              % 网络的期望输出
    
    globalVar(netInput', netOutput');
    [featureNum , sampleNum] = size(netInput);	% 得到网络的输入特征数以及训练网络所用的样本数  
    
    %fprintf('netInput '); fprintf('%f ', netInput'); fprintf('\n');
    
    n1 = nElem;
    n2 = 5;             % 隐含层的节点数
    n3 = 1;             % 输出层的节点数
    f2 = myGetFunc('tanh');    df2 = myGetFunc('dtanh');
    f3 = myGetFunc('purelin'); df3 = myGetFunc('dpurelin');
    
    w1 = rand(n2, n1); b1 = rand(n2, 1);
    w2 = rand(n3, n2); b2 = rand(n3, 1);
    L1 = netInput; Y = netOutput;
    alpha = learnRate / nData;

    for nIter = 1 : maxIter
        inputL2 = w1 * L1 + repmat(b1, 1, nData); L2 = f2(inputL2); % L2的输入和输出
        inputL3 = w2 * L2 + repmat(b2, 1, nData); L3 = f3(inputL3); % L3的输入和输出
        
        e = Y - L3;
        norm_e = norm(e);
        sigma3 = -e .* df3(inputL3);            % L3层残差
        sigma2 = w2' * sigma3 .* df2(inputL2);  % L2层残差
        
        w2 = w2 - alpha * sigma3 * L2';         % L2层权值的梯度
        w1 = w1 - alpha * sigma2 * L1';         % L1层权值的梯度
        b2 = b2 - alpha * sum(sigma3, 2);       % L2层偏置的梯度
        b1 = b1 - alpha * sum(sigma2, 2);       % L1层偏置的梯度
        
        if norm_e < eMin
            break;
        end
    end
    
    fprintf('iter=%d norm_e=%f \n', nIter, norm_e);
    
    okY = netfunc(okX); n = size(okX, 2);
    
    inputL2 = w1 * okX + repmat(b1, 1, n); L2 = f2(inputL2);
    inputL3 = w2 * L2  + repmat(b2, 1, n); L3 = f3(inputL3);
    myY = L3;
    
    hold on;
    plot(netInput, netOutput, '*');
    plot(okX, okY, 'g');
    plot(okX, myY, 'r');
    legend('train', 'perfect', 'real');
    hold off;
end

%y = 1 + sin((pi / 4) * ican * x)
function Y = netFuncSin1(X)
    i = 4;
    Y = 1 + sin(X * i * (pi/4));
end

function Y = netFuncXor(X)
    Y = xor(X(1,:), X(2,:));
end