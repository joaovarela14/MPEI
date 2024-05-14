clear all
clc

movies = readcell("movies.csv","Delimiter",',');

generos_totais = movies(1:end,3:end); 

generos = unique(generos_totais(:,1));

titulos = movies(1:end,1);

n_titulos = length(titulos);

n_generos = length(generos_totais);

anos = movies(1:end,2);

n_hash = 100;


k = 4; % Número de funções de dispersão
BF_generos = bloomFilterInitialize(1000);
BF_generos_ano = bloomFilterInitialize(1000);
[n_linhas,n_colunas] = size(movies);

for i = 1:n_linhas
    for j = 3:n_colunas
        if ~ismissing(movies{i, j})
            BF_generos = bloomFilterInsert(BF_generos, movies{i, j}, k);
        end
    end
end

for i = 1:n_linhas
    ano = num2str(movies{i, 2});   % Segunda coluna para o ano
    for j = 3:n_colunas  % Gêneros começando na terceira coluna
        if ~ismissing(movies{i, j})
            genero = movies{i, j};
            chave = [genero ',' ano]; % Criação da chave como 'Genero Ano'
            BF_generos_ano = bloomFilterInsert(BF_generos_ano, chave, k);
        end
    end
end


set_titles = createShinglesTitle(titulos);

assinaturas_opcao4 = inf(n_titulos,n_hash);

for n = 1:n_titulos
    set_n = set_titles{n};
    for i = 1:length(set_n)
        key = num2str(set_n(i));
        h_out = muxDJB31MA(key, 127, n_hash);
        assinaturas_opcao4(n,:) = min(h_out, assinaturas_opcao4(n,:));
    end
end

set_genres = createShinglesForGenres(generos_totais);

assinaturas_opcao5 = inf(n_generos,n_hash);

for n = 1:n_generos
    set_n = set_genres{n};
    for i = 1:length(set_n)
        key = num2str(set_n{i});
        h_out = muxDJB31MA(key, 127, n_hash);
        assinaturas_opcao5(n,:) = min(h_out, assinaturas_opcao5(n,:));
    end
end

clear n_colunas n_linhas ano chave ...
    genero k i j movies n_titulos shingle n_hash h_out key set_n n...
    set_genres set_titles n_generos

save dados.mat