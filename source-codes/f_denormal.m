%fungsi denormal
function [D] = f_denormal(A,ab)
    ij = size(A);
    for j = 1:1:ij(1,2)
        for i = 1:1:ij(1,1)
            D(i,j)= (A(i,j)*(ab(2,j)-ab(1,j))+ab(1,j));
        end
    end
end