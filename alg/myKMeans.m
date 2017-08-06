function [groups cents] = myKMeans(p, n_cent)
    %
    %   K-Means++算法
    %
    %   步骤:
    %       1. 从输入的数据点集合中随机选择一个点作为第一个聚类中心
    %       2. 对于数据集中的每一个点x，计算它与最近聚类中心(指已选择的聚类中心)的距离D(x),和Sum(D(x))
    %       3. 选择一个新的数据点作为新的聚类中心，选择的原则是：D(x)较大的点，被选取作为聚类中心的概率较大。
    %          然后，再取一个随机值，用权重的方式来取计算下一个“种子点”。这个算法的实现是，
    %          先取一个能落在Sum(D(x))中的随机值Random，然后用Random -= D(x)，直到其<=0，此时的点就是下一个“种子点”
    %       4. 重复2和3直到k个聚类中心被选出来
    %       5. 利用这k个初始的聚类中心来运行标准的k-means算法
    %
    %       3.
    cents = k_means_init(p, n_cent);
    groups = k_means_groups(p, cents, n_cent);
    
    while 1
        cents = calc_cent(p, groups, n_cent);
        group2 = k_means_groups(p, cents, n_cent);
        if group2 == groups
            break;
        end
        groups = group2;
    end
end

%
%   计算距离
%
function v = calc_dist(p1, p2)
    v = sum((p1-p2).^2, 2);
end

%
%   计算质心
%
function cents = calc_cent(p, groups, n_cent)
    dim = size(p, 2);
    cents = zeros(n_cent, dim);
    counts = zeros(n_cent, 1);
    m = size(p, 1);
    
    for i = 1 : m
        grp = groups(i);
        cents(grp, :) = cents(grp, : ) + p(i,:);
        counts(grp) = counts(grp) + 1;
    end
    
    cents = cents ./ repmat(counts, 1, dim);
end

%
%   k-means++法初始化种子点
%
function [cent] = k_means_init(p, n_cent)
    dim = size(p, 2);
    m = size(p, 1);
    cent = zeros(n_cent, dim);
    
    t = floor(rand()*(m-1)+1);
    cent(1,:) = p(t,:);
   
    for i = 1 : n_cent-1
        sum = 0;
        ds = zeros(m, 1);
        
        tc = cent(1:i,:);
        for j = 1 : m
            tp = repmat(p(j,:),i,1);
            dd = calc_dist(tp, tc);
            ds(j) = min(dd);
            sum = sum + ds(j);
        end
        
        sum = rand() * sum;
        for j = 1 : m
            sum = sum - ds(j);
            if sum <= 0
                cent(i+1,:) = p(j,:);
                break;
            end
        end
    end
end

function [groups] = k_means_groups(p, cents, n_cent)
    m = size(p, 1);
    groups = zeros(m, 1);
    for j = 1 : m;
        tp = repmat(p(j,:), n_cent, 1);
        dd = calc_dist(tp, cents);
        [tv, pos] = min(dd);
        groups(j) = pos;
    end
end
