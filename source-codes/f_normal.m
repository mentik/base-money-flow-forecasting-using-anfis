%Function untuk menormalkan data train
function [N P] = f_normal(x)
    U = size(x);
    for j = 1:1:U(1,2)
        P(1,j) = min(x(:,j));
        P(2,j) = max(x(:,j));
        for i = 1:1:U(1,1)
            N(i,j)= (x(i,j)-P(1,j))/(P(2,j)-P(1,j));
        end
    end
end
        
            
            
            
    