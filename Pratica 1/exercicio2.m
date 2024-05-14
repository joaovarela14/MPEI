experiencias = rand(3,10000);

lancamentos = experiencias > 0.5;

resultados= sum(lancamentos);

sucessos= resultados==2;

probSimulacao= sum(sucessos)/10000


%%

N= 1e5; %nu´mero de experieˆncias =  10000
p = 0.5; %probabilidade de cara 
k = 2; %nu´mero de caras
n = 3; %nu´mero de lanc¸amentos
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)==k;
probSimulacaoSimples= sum(sucessos)/N