function [groups cents] = myKMeans(p, n_cent)
    %
    %   K-Means++�㷨
    %
    %   ����:
    %       1. ����������ݵ㼯�������ѡ��һ������Ϊ��һ����������
    %       2. �������ݼ��е�ÿһ����x���������������������(ָ��ѡ��ľ�������)�ľ���D(x),��Sum(D(x))
    %       3. ѡ��һ���µ����ݵ���Ϊ�µľ������ģ�ѡ���ԭ���ǣ�D(x)�ϴ�ĵ㣬��ѡȡ��Ϊ�������ĵĸ��ʽϴ�
    %          Ȼ����ȡһ�����ֵ����Ȩ�صķ�ʽ��ȡ������һ�������ӵ㡱������㷨��ʵ���ǣ�
    %          ��ȡһ��������Sum(D(x))�е����ֵRandom��Ȼ����Random -= D(x)��ֱ����<=0����ʱ�ĵ������һ�������ӵ㡱
    %       4. �ظ�2��3ֱ��k���������ı�ѡ����
    %       5. ������k����ʼ�ľ������������б�׼��k-means�㷨
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
%   �������
%
function v = calc_dist(p1, p2)
    v = sum((p1-p2).^2, 2);
end

%
%   ��������
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
%   k-means++����ʼ�����ӵ�
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
