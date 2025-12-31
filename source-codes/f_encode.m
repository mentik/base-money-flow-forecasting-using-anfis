function [E] = f_encode(bulan,m)
    dat = bulan;
    code = m;
    E = 0;
    for i = 1:1:length(dat)
        for x = 1:1:12
            if dat(i)==x
                E(i,1)=code(x);
            end
        end
    end
    E;
end