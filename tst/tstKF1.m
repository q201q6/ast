function tstKF1(what)
    %
    % �򵥵Ŀ������˲�ʾ������: λ�ƺ��ٶȵ�С������
    %
    myInit;

    N = 100;
    T  = 1:N;
    v  = 0.2;
    ZA = v * T'; %�۲�ֵ
    noise = randn(1, N)';
    Z = ZA + noise;

    X = [0; 0]; %״̬����
    P = [1 0; 0 1]; %״̬Э�������
    F = [1 1; 0 1]; %״̬ת�ƾ���
    %Q = [0.0001 0; 0 0.0001]; %״̬ת��Э�������
    Q = [0.001 0; 0 0.001]; %״̬ת��Э�������
    H = [1 0]; %�۲����
    R = 1; %�۲���������

    %���ڲ���
    XX = zeros(N, 2);
    ZZ = zeros(N, 2);

    for i = 1:N
        %�����˲���5����ʽ
        X_ = F*X; 
        P_ = F*P*F' + Q;
        K  = P_*H'*pinv(H*P_*H' + R);
        X  = X_ + K*(Z(i) - H*X_);
        P  = (eye(2) - K*H)*P_;

        %���ڲ���
        XX(i,:) = X;
        tmp = 0;
        if i > 1
            tmp = Z(i-1);
        end
        ZZ(i,:) = [Z(i) (Z(i)-tmp)];
    end

    hold on;
        title('λ�ƱȽ�');
        plot(T, ZA, 'g');
        plot(T, ZZ(:,1), 'r');
        plot(T, XX(:,1), 'b');
        legend('��ʵֵ', '�۲�ֵ', '�����˲�ֵ');
    hold off;

    figure; hold on;
        title('�ٶȱȽ�');
        plot(T, v*ones(size(T)), 'g');
        plot(T, ZZ(:,2),'r');
        plot(T, XX(:,2),'b');
        legend('��ʵֵ', '�۲�ֵ', '�����˲�ֵ');
    hold off;

    figure; hold on;
        title('λ��ƫ��Ƚ�');
        plot(T, ZZ(:,1)-ZA, 'r');
        plot(T, XX(:,1)-ZA, 'b');
        legend('��ʵֵ', '�����˲�ֵ');
    hold off;

end

