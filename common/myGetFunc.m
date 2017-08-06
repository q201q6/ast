function fn = myGetFunc(what)
    %
    %   »ñÈ¡º¯Êý
    %
    if strcmp(what, 'myNothing')
        fn = @myNothing;
    elseif strcmp(what, 'derf')
        fn = @derf;
    elseif strcmp(what, 'dpurelin')
        fn = @dpurelin;
    elseif strcmp(what, 'dsigmoid')
        fn = @dsigmoid;
    elseif strcmp(what, 'dtanh')
        fn = @dtanh;
    elseif strcmp(what, 'dtansig')
        fn = @dtansig;
    elseif strcmp(what, 'mySignPredict')
        fn = @mySignPredict;
    elseif strcmp(what, 'myResult')
        fn = @myResult;
    elseif strcmp(what, 'myPredict')
        fn = @myPredict;
    elseif strcmp(what, 'purelin')
        fn = @purelin;
    elseif strcmp(what, 'sigmoid')
        fn = @sigmoid;
    elseif strcmp(what, 'tanh')
        fn = @tanh;
    elseif strcmp(what, 'tansig')
        fn = @tansig;
    else
        fn = @myNothing;
    end

end

function v = mySignPredict(x)
    v = sign(x);
end

function [A] = myResult(X1, X2, theta, FUN)
    if nargin < 4
        FUN=@(x1,x2)([ones(size(x1,1),1) x1(:,1) x2(:,1)]);
    end
    
    X = FUN(X1, X2);
    A = X * theta;
end

function v = myPredict(x)
    v = x >= 0.5;
end

function [v] = dtanh(x)
    v = 1 - tanh(x) .^ 2;
end

function [v] = dsigmoid(z)
    v = sigmoid(z);
    v = v .* (1 - v);
end

function [v] = derf(z)
    v = z - z;
end

function v = sigmoid(z)
    v = 1 ./ (1 + exp(-z));
end

function myNothing
end
