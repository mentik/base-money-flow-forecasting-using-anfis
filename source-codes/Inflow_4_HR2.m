% Walk Forward Validation
fprintf('******** Program Prediksi Inflow/OutFlow ANFIS ******** \n');
fprintf('Tekan 1 untuk Inflow dan 2 untuk Outflow \n');
clear; %Membersihkan workspace
in = input('Masukkan INPUT = ');
out = input('Masukkan OUTPUT = ');
p = input ('Masukkan PARTISI = ');
s = 24; %Jumlah simulasi
fprintf('Catatan: Test split sebanyak %g segmen terakhir \n',s);
data_csv = csvread('data.csv',1,1);
p_kolom = 1;
ia = 4;
ib = 6;
ic = 0;
id = 2;
tic;
for bg = ia:0.1:ib
    p_baris = 1;
    for bi = ic:0.1:id
        file = [data_csv(:,1:2) ((data_csv(:,3)* 3.8) + (data_csv(:,4)* 1.1) + (data_csv(:,5)* bg) + (data_csv(:,6)* bi))];
        for i = 1:1:s 
            %Menjalankan simulasi
            t = s+1-i; 
            split = length(file)-t; 
            %Normalisasi
            [pre_train ab] = f_normal(file(1:split,:)); %Normalisasi data pre_train
            pre_test = f_normal_x(file(split+1,:),ab); %Normalisasi pre_test ke ab
            simulasi = [pre_train; pre_test]; %Membentuk data simulasi
            %Sliding window data simulasi
            dataset = f_swts_matrix(simulasi,p,in,out,[1 0]);
            train = dataset(1:split-p,:);
            test = dataset(split+1-p,:);
            %Generasi arsitektur ANFIS
            fis = genfis1(train,2,'gbellmf','constant');
            epoch_n = [30 0];
            dispOpt = zeros(1,4);
            %Menjalankan pelatihan
            fis = anfis(train,fis,epoch_n,dispOpt);
            %Memprediksi test
            Y(i,1) = f_denormal(test(1,end),ab(:,out)); %Aktual
            Y(i,2) = f_denormal(evalfis(test(1,1:end-1),fis),ab(:,out)); %Hasil
        end
        rmse_outflow(p_baris,p_kolom) = f_rmse(Y)
        mape_outflow(p_baris,p_kolom) = f_mape(Y)
        clear Y;
        p_baris = p_baris + 1;
    end
    p_kolom = p_kolom + 1;
end
toc;
figure(1);
surf(ia:0.1:ib,ic:0.1:id,mape_outflow,'FaceColor','none','LineStyle','none','Marker','.','MarkerEdgeColor','flat','MarkerSize',8);
xlabel('Nyepi (X)');
ylabel('Saraswati - Pegerwesi (Y)');
zlabel('MAPE (Z)');
figure(2);
surf(ia:0.1:ib,ic:0.1:id,rmse_outflow,'FaceColor','none','LineStyle','none','Marker','.','MarkerEdgeColor','flat','MarkerSize',8);
xlabel('Nyepi (X)');
ylabel('Saraswati - Pagerwesi (Y)');
zlabel('NRMSE (Z)');