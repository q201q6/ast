function tstLine(what, track)
        % 
        %   线性神经网络
        %
        myInit;    
        x1s = -1:0.1:1;
        x2s = x1s;
        eMin = 0.0001;
        myResult = myGetFunc('myResult');

        if nargin < 1
                what = 'oth';
        end
        if nargin < 2
                track = 0;
        end

        %数据
        dataXOR = [ ... %XOR
                1 0 0 -1;
                1 0 1 1;
                1 1 0 1;
                1 1 1 -1];
        dataOTH = [ ...
                1 3 3 1;
                1 4 3 1;
                1 1 1 -1];

        %
        % 注意: 学习率要选择合适的值,太小收敛太慢;太大则发散,不收敛
        if strcmp(what, 'xor')
                data = dataXOR;
                alpha = 0.1; %学习率
        else
                what = 'oth';
                data = dataOTH;
                alpha = 0.006; %学习率
        end

        fprintf('tstLine [%s] ...\n', what);

        XI = data(:,1:3); %输入
        YI = data(:,4); %输出
        plotLjData(XI, YI, [-5 5;-10 15]);

        X = myMapFeature2(XI(:,2), XI(:,3));
        Y = YI;
        m = size(X,1); %样本个数
        n = size(X,2); %输入数据个数
        lambda = 0;
        %alpha = 0.1; %学习率
        maxIter = 10000; %最大迭代次数
        W = rand(n, 1); %权值矩阵
        XT = X'; %X的转置

        %
        %   Y = X * W
        %
        for i = 1:maxIter
                H = X * W; %当前权值的输出
                r = Y - H; %残差
                deltaW = (alpha / m) * XT * r;

                norm_r = norm(r);
                %fprintf('%d-th norm=%f \n', i, norm_r);
                if norm_r < eMin
                        break;
                end
                W = W + deltaW;

                if track >= 0.5
                        fprintf('[%d] r=%f ', i, norm(r)); fprintf('%f ', W);fprintf('\n');
                        plotContour0(W, 0, x1s, x2s, @myMapFeature2, i, norm(r));pause(0.001);
                end
        end

        plotContour0(W, 0, x1s, x2s, @myMapFeature2);
        fprintf('\n');
        fprintf('NOW W = ');fprintf('%f ', W);fprintf('\n');
        fprintf('    a = ');fprintf('%f ', myResult(X(:,2), X(:,3), W, @myMapFeature2)); fprintf('\n');
        fprintf('    Y = ');fprintf('%f ', Y);fprintf('\n');
end
