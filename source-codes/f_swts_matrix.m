%Function Sliding Window Time Series Analysis (SWTS)
%Program dijalankan dengan memanggil syntax 'swts'
%Argumen p menyatakan panjang waktu
%Argumen input dan output dapat diisi angka 1 (inflow) dan 2 (outflow)
%Argumen dummy diisi angka 0 (tidak menggunakan) dan 1 (menggunakan)
function [ K ] = f_swts_matrix(M,p,input,output,d)
    %3.2 Penyiapan Data
    format bank; %Tampilan 2 digit desimal
    %3.3 Sliding Window Time Series Analysis
    s = length(M)-p; %Total segmen data
    K = zeros(s,p); %Ukuran output matriks SWTS
    for x = 1:1:s %Iterasi data tiap baris
        for t = 1:1:p %Iterasi kolom inflow pada baris
            K(x,t) = M(t+(x-1),input); %Mengisi data tiap baris input
        end;
        if (d(1)==1)
            K(x,p+d(1)) = M(x+p,3); %Mengisi dummy HR
        end;
        if (d(2)==1)
            K(x,p+d(1)+d(2)) = M(x+p,4); %Mengisi dummy Bulan
        end;
            K(x,p+d(1)+d(2)+1) = M(t+x,output); %Mengisi data output
    end;
end