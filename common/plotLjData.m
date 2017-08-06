function plotLjData(X, Y, Z)
    %
    % 绘制2个输入变量的逻辑图
    %
    % X:  X1
    % Y:  X2
    %
    
    pos = find(Y > 0);
    neg = find(Y < 0);
    oth = find(Y == 0);
    
    
    hold on;
    plot(X(pos,2), X(pos,3), 'gd', 'MarkerFaceColor', 'b', 'LineWidth', 1, 'MarkerSize', 7);
    plot(X(neg,2), X(neg,3), 'ks', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
    plot(X(oth,2), X(oth,3), 'ko', 'MarkerFaceColor', 'g', 'MarkerSize', 7);
    if nargin > 2 & size(Z) == [2 2]
        z1 = Z(1); z2 = Z(2);
        text(Z(1,1), Z(1,2), '');
        text(Z(2,1), Z(2,2), '');
    end
    xlabel('x1');
    ylabel('x2');

    if isempty(oth)
        legend('Pos', 'Neg');
    else
        legend('Pos', 'Neg', 'Zero');
    end
    hold off;
end