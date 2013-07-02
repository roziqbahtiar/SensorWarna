P = [255    0   0   ;%P1 merah
     255    0   128 ;%P2 merah
     255    0   255 ;%P3 merah
     0  0   255 ;%P4 biru
     0  128 255 ;%P5 biru
     0  255 255 ;%P6 biru
     0  255 128 ;%P7 hijau
     0  255 0   ;%P8 hijau
     128    255 0  ];%P9 hijau
 
T =     [1  0   0;  %1 merah
     1  0   0;  %2 merah
     1  0   0;  %3 merah
     0  1   0;  %4 biru
     0  1   0;  %5 biru
     0  1   0;  %6 biru
     0  0   1;  %7 hijau
     0  0   1;  %8 hijau
     0  0   1]; %9 hijau
 
JumPola  = length(P(:,1));  % Jumlah semua pola latih (11)
DimPola  = length(P(1,:));  % Dimensi pola latih (3)
JOneuron = length(T(1,:));  % Jumlah neurons pada Output layer (1)
 
JHneuron = 9;           % Jumlah neurons pada Hidden layer
LR       = 0.1;         % Learning Rate
Epoch    = 10000;       % Maksimum iterasi
MaxMSE   = 10^-5;       % Maksimum MSE
 
%--------------------------------------------------------------------------
% Bangkitkan Weights antara Input layer dan Hidden layer secara acak
% dalam interval -1 sampai +1. Simpan sebagai W1.
%--------------------------------------------------------------------------
W1 = [];
for ii=1:JHneuron,
    W1 = [W1 ; (rand(1,DimPola)*2-1)];
end
W1 = W1';
 
%--------------------------------------------------------------------------
% Bangkitkan Weights antara Hidden layer dan Output layer secara acak
% dalam interval -1 sampai +1. Simpan sebagai W2.
%--------------------------------------------------------------------------
W2 = [];
for jj=1:JOneuron,
    W2 = [W2 ; (rand(1,JHneuron)*2-1)];
end
W2 = W2';
 
MSEepoch = MaxMSE + 1;  % Mean Square Error untuk 1 epoch
MSE = [];       % List MSE untuk seluruh epoch
ee   = 1;       % Index Epoch
 
while(ee <= Epoch) & (MSEepoch > MaxMSE)
    MSEepoch = 0;
    for pp=1:JumPola,
        CP = P(pp,:);   % Current Pattern
        CT = T(pp,:);   % Current Target
 
        %-----------------------------------------------------------
        % Perhitungan Maju untuk mendapatkan Output, Error, dan MSE
        %-----------------------------------------------------------
        A1=[];
        for ii=1:JHneuron,
            v  = CP*W1(:,ii);
            A1 = [A1 1/(1+exp(-v))];
        end
        A2=[];
        for jj=1:JOneuron,
            v  = A1*W2(:,jj);
            A2 = [A2 1/(1+exp(-v))];
        end
        Error = CT - A2;
 
        for kk=1:length(Error),
            MSEepoch = MSEepoch + Error(kk)^2;
        end
        %-----------------------------------------------------------
        % Perhitungan Mundur untuk meng-update W1 dan W2
        %-----------------------------------------------------------
        for kk=1:JOneuron,
            D2(kk) = A2(kk) * (1-A2(kk)) * Error(kk);
        end
        dW2 = [];
        for jj=1:JHneuron,
            for kk=1:JOneuron,
                delta2(kk) = LR * D2(kk) * A1(jj);
            end
            dW2 = [dW2 ; delta2];
        end
        for jj=1:JHneuron,
            D1(jj) = A1 * (1-A1)' * D2 * W2(jj,:)';
        end
        dW1 = [];
        for ii=1:DimPola,
            for jj=1:JHneuron,
                delta1(jj) = LR * D1(jj) * CP(ii);
            end
            dW1 = [dW1 ; delta1];
        end
        W1 = W1 + dW1;  % W1 baru
        W2 = W2 + dW2;  % W2 baru
    end
    MSE = [MSE (MSEepoch/JumPola)];
    ee  = ee + 1;
end
plot(MSE);
xlabel('Epoch')
ylabel('MSE')
 
%program uji
TestSet = ...
    [255 0 255];
 
Kelas = [];
 
JumPola = length(TestSet(:,1));
JumBenar = 0;
for pp=1:JumPola,
    CP = TestSet(pp,:);
    A1 = [];
    for ii=1:JHneuron,
        v  = CP*W1(:,ii);
        A1 = [A1 1/(1+exp(-v))];
    end
    A2 = [];
    for jj=1:JOneuron,
        v  = A1*W2(:,jj);
        A2 = [A2 1/(1+exp(-v))];
    end
 
    %----------------------------------------
    % Pemetaan A2 menjadi kelas keputusan
    % Jika A2 < 0.5 maka Kelas = 0
    %----------------------------------------
    for jj=1:JOneuron,
        if A2(jj) < 0.5,
            Kelas(jj) = 0;
        else
            Kelas(jj) = 1;
        end
    end
end
Kelas
 
W1
W2
A1
A2