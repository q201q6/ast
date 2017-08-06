function tstRBF(what)
    %
    %   RBF神经网络
    %
    
    myInit;
    if nargin < 1
        what = '';
    end

    if strcmp(what, 'xor')
        n = 2;
        m = 4;
        n_cent = 2;
        noise = [ 0 0 0 0];
        input = [0 0; 0 1; 1 0; 1 1]';
        tstInput = input;
        tstFunc = @FuncXor;
    else
        n = 1;
        m = 100;
        n_cent = 11;
        noise = 0.3 * randn(1, m);
        input = 8 * rand(1, m) - 4;
        tstInput = -4:0.08:4;
        tstFunc = @Func1;
        %output = 1.1 * (1 - input + 2 * input .^ 2) .* exp(-input .^ 2 / 2) + noise;
        %tstOutput = 1.1 * (1 - tstInput + 2 * tstInput .^ 2) .* exp(-tstInput .^ 2 / 2);
    end
    
    sigma_factor = 1 / sqrt(2 * n_cent);
    tstM = size(tstInput, 2);
    output = tstFunc(input, noise);
    tstOutput = tstFunc(tstInput);
    
    % k-means算法计算隐含层中心
    [grps cents] = myKMeans(input', n_cent);
    
    % 计算最大距离
    k = 0;
    ds = zeros(1,(n_cent)*(n_cent-1)/2);
    for i = 2 : n_cent
        for j = 1 : i
            k = k + 1;
            ds(1,k) = calc_dist(cents(j,:), cents(i,:));
        end
    end
    dmax = max(ds);
    sigma = sigma_factor * dmax;
    
    % 计算隐含节点
    pha = zeros(n_cent, m);
    factor = 1 / (2 * sigma * sigma);
    for i = 1 : m
        t = repmat(input(:,i)', n_cent, 1) - cents;
        t2 = sum(-factor * (t.^2), 2);
        pha(:,i) = exp(t2);
    end
    
    % 计算权矩阵; W * pha2 = Y =>  W = Y * pinv(pha2)
    pha2 = [ones(1,m); pha];
    W = output * pinv(pha2);
    
    % 计算测试的隐藏层
    tstPha = zeros(n_cent, tstM);
    for i = 1 : tstM
        t = repmat(tstInput(:,i)', n_cent, 1) - cents;
        t2 = sum(-factor * (t.^2), 2);
        tstPha(:,i) = exp(t2);
    end
    
    % 计算测试的输出
    tstPha2 = [ones(1,tstM); tstPha];
    tstY = W * tstPha2;
    
    hold on;
    grid;
    
    if strcmp(what, 'xor')
        fprintf('Input  = '); fprintf('%f ', tstInput); fprintf('\n');
        fprintf('Output = '); fprintf('%f ', output); fprintf('\n');
        fprintf('YYYYYY = '); fprintf('%f ', tstOutput); fprintf('\n');
    else
        plot(input, output, 'k+');
        plot(tstInput, tstOutput, 'r--'); 
        plot(tstInput, tstY, 'g--'); 
    end
    
    hold off;
end

function v = calc_dist(p1, p2)
    v = sum((p1-p2).^2, 2);
    v = sqrt(v);
end

function Y = Func1(X, noise)
    Y = 1.1 * (1 - X + 2 * X .^ 2) .* exp(- X .^ 2 / 2);
    if nargin > 1
        Y = Y + noise;
    end
end

function Y = FuncXor(X, noise)
    Y = xor(X(1,:), X(2,:));
    if nargin > 1
        Y = Y + noise;
    end
end

