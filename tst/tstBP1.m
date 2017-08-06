function tstBP1(what)
    %
    %       һ�����ز��bp������
    %
    %       �����L1   ���ز�L2    �����L3
    %       n1          n2          n3      �ڵ����
    %                   f2          f3      ��������
    %       w1          w2                  Ȩ��
    %       b1          b2                  ��ֵ
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
        netInput  = okX;                            % �����ѵ������
    else
        % y = 1 + sin(x*K*pi/4)
        netfunc = @netFuncSin1;
        okX = -2:0.05:2;
        netInput  = [-2 : 0.4 : 2];                 % �����ѵ������
    end
    
    netOutput = netfunc(netInput);              % ������������
    
    globalVar(netInput', netOutput');
    [featureNum , sampleNum] = size(netInput);	% �õ�����������������Լ�ѵ���������õ�������  
    
    %fprintf('netInput '); fprintf('%f ', netInput'); fprintf('\n');
    
    n1 = nElem;
    n2 = 5;             % ������Ľڵ���
    n3 = 1;             % �����Ľڵ���
    f2 = myGetFunc('tanh');    df2 = myGetFunc('dtanh');
    f3 = myGetFunc('purelin'); df3 = myGetFunc('dpurelin');
    
    w1 = rand(n2, n1); b1 = rand(n2, 1);
    w2 = rand(n3, n2); b2 = rand(n3, 1);
    L1 = netInput; Y = netOutput;
    alpha = learnRate / nData;

    for nIter = 1 : maxIter
        inputL2 = w1 * L1 + repmat(b1, 1, nData); L2 = f2(inputL2); % L2����������
        inputL3 = w2 * L2 + repmat(b2, 1, nData); L3 = f3(inputL3); % L3����������
        
        e = Y - L3;
        norm_e = norm(e);
        sigma3 = -e .* df3(inputL3);            % L3��в�
        sigma2 = w2' * sigma3 .* df2(inputL2);  % L2��в�
        
        w2 = w2 - alpha * sigma3 * L2';         % L2��Ȩֵ���ݶ�
        w1 = w1 - alpha * sigma2 * L1';         % L1��Ȩֵ���ݶ�
        b2 = b2 - alpha * sum(sigma3, 2);       % L2��ƫ�õ��ݶ�
        b1 = b1 - alpha * sum(sigma2, 2);       % L1��ƫ�õ��ݶ�
        
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