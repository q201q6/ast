function tstLine(what, track)
        % 
        %   ����������
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

        %����
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
        % ע��: ѧϰ��Ҫѡ����ʵ�ֵ,̫С����̫��;̫����ɢ,������
        if strcmp(what, 'xor')
                data = dataXOR;
                alpha = 0.1; %ѧϰ��
        else
                what = 'oth';
                data = dataOTH;
                alpha = 0.006; %ѧϰ��
        end

        fprintf('tstLine [%s] ...\n', what);

        XI = data(:,1:3); %����
        YI = data(:,4); %���
        plotLjData(XI, YI, [-5 5;-10 15]);

        X = myMapFeature2(XI(:,2), XI(:,3));
        Y = YI;
        m = size(X,1); %��������
        n = size(X,2); %�������ݸ���
        lambda = 0;
        %alpha = 0.1; %ѧϰ��
        maxIter = 10000; %����������
        W = rand(n, 1); %Ȩֵ����
        XT = X'; %X��ת��

        %
        %   Y = X * W
        %
        for i = 1:maxIter
                H = X * W; %��ǰȨֵ�����
                r = Y - H; %�в�
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
