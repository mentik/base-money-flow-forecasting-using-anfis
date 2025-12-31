%Function untuk menormalkan data test
function [N] = f_normal_x(x,P)
    U = size(x);
    for j = 1:1:U(1,2)
        min = P(1,j);
        max = P(2,j);
        for i = 1:1:U(1,1)
            N(i,j)= (x(i,j)-min)/(max-min);
        end
    end
end