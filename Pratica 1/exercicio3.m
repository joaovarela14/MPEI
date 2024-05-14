N= 1e5; %nu´mero de experieˆncias
p = 0.5; %probabilidade de cara
k = 6; %nu´mero de caras
n = 15;

lancamentos = rand(n,N);

lancamentos = lancamentos >0.5;

sucessos = sum(lancamentos)==k;

prob = sum(sucessos)/N

