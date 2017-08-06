
function tstBP(what)
    %
    %   BP������
    %
    myInit;
    sigmoid = myGetFunc('sigmoid');
    dsigmoid = myGetFunc('dsigmoid');
    
    % �������������밴�б���,����ƫ�ò����浽���������
    dataXOR = [ ... %���
        0 0 0;
        0 1 1;
        1 0 1;
        1 1 0];
    
    if nargin < 1
        what = 'oth';
    end
    if strcmp(what, 'xor')
        data = dataXOR;
    else
        what = 'xor';
        data = dataXOR;
    end
    fprintf('tst BP [%s]...\n', what);
    
    X = data(:,1:2)';
    Y = data(:,3)';
    m = size(X,2);	%������������
    k = 4;          %���ؽڵ����
    n = size(X,1);  %������������������
    %plotLjData(X, Y);
   
    %
    %   L1 = f( X  * V );
    %   L2 = f( L1 * W );
    %
    %   x(1)	y1
    %   x(2)    y2      o
    %           y3
    %           y4
    %
    %   2       4       1
    %   IN      L2      L3
    %
    lambda = 0;
    iterMax = 20000;	%����������
    lr = 0.44;	%ѧϰ��
    W1 = rand(k, n); b1 = rand(k, 1);
    W2 = rand(1, k); b2 = rand(1, 1);
    
%     for iter = 1 : iterMax
%         L1 = sigmoid(X
%     end
    
    for iter = 1 : iterMax
        dW2 = zeros(size(W2)); db2 = zeros(size(b2));
        dW1 = zeros(size(W1)); db1 = zeros(size(b1));
        for i = 1:m
            a1 = X(:,i); %����i�ĵ�һ��(�����)
            d  = Y(:,i); %����i�����������
            z2 = W1 * a1 + b1; a2 = sigmoid(z2); %��2���������
            z3 = W2 * a2 + b2; a3 = sigmoid(z3); %��3���������
            sigma3 = - (d - a3) .* dsigmoid(z3); %��3��в�
            sigma2 = (W2' * sigma3) .* dsigmoid(z2); %��2��в�
            dW2 = dW2 + sigma3 * a2';
            dW1 = dW1 + sigma2 * a1';
            db2 = db2 + sigma3;
            db1 = db1 + sigma2;
        end
        
        W2 = W2 - (lr/m) * dW2  - lambda * W2;
        W1 = W1 - (lr/m) * dW1  - lambda * W1;
        b2 = b2 - (lr/m) * db2;
        b1 = b1 - (lr/m) * db1;
        
        L2 = sigmoid(W1 * X  + repmat(b1, 1, m));
        L3 = sigmoid(W2 * L2 + repmat(b2, 1, m));
        fprintf('NOW A = '); fprintf('%f ', L3); fprintf('\n');
        pause;
    end
    
    L2 = sigmoid(W1 * X  + repmat(b1, 1, m));
    L3 = sigmoid(W2 * L2 + repmat(b2, 1, m));
    fprintf('NOW A = '); fprintf('%f ', L3); fprintf('\n');
    fprintf('    Y = '); fprintf('%f ', Y); fprintf('\n');
    
end
