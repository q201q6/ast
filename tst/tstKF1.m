function tstKF1(what)
    %
    % 简单的卡尔曼滤波示例代码: 位移和速度的小车例子
    %
    myInit;

    N = 100;
    T  = 1:N;
    v  = 0.2;
    ZA = v * T'; %观测值
    noise = randn(1, N)';
    Z = ZA + noise;

    X = [0; 0]; %状态矩阵
    P = [1 0; 0 1]; %状态协方差矩阵
    F = [1 1; 0 1]; %状态转移矩阵
    %Q = [0.0001 0; 0 0.0001]; %状态转移协方差矩阵
    Q = [0.001 0; 0 0.001]; %状态转移协方差矩阵
    H = [1 0]; %观测矩阵
    R = 1; %观测噪声方差

    %用于测试
    XX = zeros(N, 2);
    ZZ = zeros(N, 2);

    for i = 1:N
        %卡曼滤波的5个公式
        X_ = F*X; 
        P_ = F*P*F' + Q;
        K  = P_*H'*pinv(H*P_*H' + R);
        X  = X_ + K*(Z(i) - H*X_);
        P  = (eye(2) - K*H)*P_;

        %用于测试
        XX(i,:) = X;
        tmp = 0;
        if i > 1
            tmp = Z(i-1);
        end
        ZZ(i,:) = [Z(i) (Z(i)-tmp)];
    end

    hold on;
        title('位移比较');
        plot(T, ZA, 'g');
        plot(T, ZZ(:,1), 'r');
        plot(T, XX(:,1), 'b');
        legend('真实值', '观测值', '卡曼滤波值');
    hold off;

    figure; hold on;
        title('速度比较');
        plot(T, v*ones(size(T)), 'g');
        plot(T, ZZ(:,2),'r');
        plot(T, XX(:,2),'b');
        legend('真实值', '观测值', '卡曼滤波值');
    hold off;

    figure; hold on;
        title('位移偏差比较');
        plot(T, ZZ(:,1)-ZA, 'r');
        plot(T, XX(:,1)-ZA, 'b');
        legend('真实值', '卡曼滤波值');
    hold off;

end

