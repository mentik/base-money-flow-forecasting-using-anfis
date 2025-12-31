%Program untuk menghitung NRMSE
function [M percent] = f_rmse(m)
dat = m;
n = length(dat);
sum = 0;
    for i = 1:1:n
        X(i,1) = (dat(i,1)-dat(i,2))^2;
    end
M = sqrt(mean(X))/(max(dat(:,1))-min(dat(:,1)));
end