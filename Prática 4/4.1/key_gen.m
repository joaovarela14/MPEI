function array = key_gen (N,i_min,i_max,vetor,vetor_probabilidades)
    
    array = cell(1,N);
   
    for i=1:N
        tamanho = floor((i_max+1-i_min)*rand()+i_min);
        string='';
    
        switch nargin
            case 4
                for j=0:tamanho
                  string=strcat(string,vetor(floor((length(vetor)+1-1)*rand()+1)));
                end
            case 5
                prob_chars = vetor_probabilidades/sum(vetor_probabilidades);
                for j=0:tamanho
                    U = rand();
                    char = 1 + sum(U > cumsum(prob_chars));
                    string=strcat(string,vetor(char));
                end
        end
        array{i} = string;
    end
end
