function [R] = f_mean_encoding(train,out)
    dat = train;
    C = zeros(12,2);
    for i = 1:1:12
        for x = 1:1:length(dat)
            if dat(x,4)==i
                C(i,1) = C(i,1) + dat(x,out);
                C(i,2) = C(i,2) + 1;
            end
        end
    R = C(:,1)./C(:,2);   
    end
end