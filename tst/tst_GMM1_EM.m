function tst_GMM1_EM()
    %
    %   使用EM算法解决单元高斯分布混合模型的示例代码
    %
    clear; close all; clc;
    
    LEN = 1000;
    len1 = fix(LEN*0.4);
    len2 = fix(LEN*0.6);
    len3 = fix(LEN*0.1);
    mu1 = 1; sigma1 = 1;
    mu2 = 5; sigma2 = 2;
    mu3 = 8; sigma3 = 1;
    dat1 = normrnd(mu1, sigma1, [1 len1]);
    dat2 = normrnd(mu2, sigma2, [1 len2]);
    dat3 = normrnd(mu3, sigma3, [1 len3]);
    %data = [dat1 dat2 dat3];M = 3;
    data = [dat1 dat2];M = 2;
    
    maxIter = 10000;
    eMin = 1e-5;
    
    % 初始化参数
    [mu sigmaE2 phi] = GMM_EM_Init1(data, M);
    %[mu sigmaE2 phi] = GMM_EM_Init(data, M);
    debug_info(0, mu, sigmaE2, phi);
    
    for i = 1:maxIter
        % E-step
        Q = GMM_EM_Step_E(data, M, mu, sigmaE2, phi);
        muOld = mu; sigmaE2Old = sigmaE2;      
        
        % M-step
        [mu sigmaE2, phi] = GMM_EM_Step_M(data, M, mu, sigmaE2, phi, Q);
        
        debug_info(i, mu, sigmaE2, phi);
        
        a = sum(abs(mu - muOld), 2);
        b = sum(abs(sigmaE2 - sigmaE2Old), 2);
        if sum(a) < eMin && sum(b) < eMin
            break;
        end
    end
    
    
end

% 高斯分布的概率密度函数
function y = normal_distribution(mu, sigmaE2, x)
    a = 1 / sqrt(2*sigmaE2*pi);
    b = (x - mu) .^ 2;
    y = a * exp(-b/(2*sigmaE2));
end

% 初始化参数
function [mu sigmaE2 phi] = GMM_EM_Init(data, M)
    N = size(data, 2);
    data2 = [data' zeros(N,1)];
    [mygrps mycents] = myKMeans(data2, M);
    phi = zeros(M, 1);
    mu = zeros(M, 1);
    sigmaE2 = zeros(M, 1);
    mu = mycents(:,1);
    
    for i = 1:M
        dat = data(find(mygrps == i));
        sigmaE2(i) = var(dat);
        phi(i) = size(dat,2) / N;
    end
end

% 初始化参数
function [mu sigmaE2 phi] = GMM_EM_Init1(data, M)
    N = size(data, 2);
    phi = zeros(M, 1);
    mu = zeros(M, 1);
    sigmaE2 = zeros(M, 1);
    
    phi = ones(M, 1) / M;
    sigmaE2 = ones(M, 1);
    for i = 1:M
        j = fix(rand * N +1);
        mu(i) = data(j);
    end
end


% E-step
function Q = GMM_EM_Step_E(data, M, mu, sigmaE2, phi)
    N = size(data, 2);
    Q = zeros(M, N);
    a = zeros(1, N);
    
    for i = 1:M
        tmp = phi(i) * normal_distribution(mu(i), sigmaE2(i), data);
        Q(i,:) = tmp;
        a = a + tmp;
    end
    
    Q = Q ./ repmat(a,M,1);
end

% M-step
function [mu sigmaE2, phi] = GMM_EM_Step_M(data, M, mu0, sigmaE2_0, phi0, Q)
    N = size(data, 2);
    phi = zeros(M, 1);
    mu = zeros(M, 1);
    sigmaE2 = zeros(M, 1);
    
    sumQ = sum(Q,2);
    dats = repmat(data, M, 1);
    mu = sum(Q.*dats, 2) ./ sumQ;
    
    t1 = dats - repmat(mu, 1, N);
    sigmaE2 = sum(Q.*t1.*t1, 2) ./ sumQ;
    
    phi = sumQ / N;
end

function debug_info(i, mu, sigmaE2, phi)
    fprintf('[%d] mu=[', i);
    fprintf('%f ', mu);
    fprintf('] sigma=[');
    fprintf('%f ', sqrt(sigmaE2));
    fprintf('] phi=[');
    fprintf('%f ', phi);
    fprintf(']\n');
end



