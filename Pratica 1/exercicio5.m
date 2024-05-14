function probSimulacao = calculo(N,p,k,n)

lancamentos = rand(n,N);

lancamentos = lancamentos >p;

sucessos = sum(lancamentos)>=k;

probSimulacao = sum(sucessos)/N

end
