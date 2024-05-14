clear all; %#ok
load dados.mat
%%
clc
choice = 0;

while choice ~= 6
    fprintf('\n---------------------------------\n')
    fprintf('1 - Display available genres\n');
    fprintf('2 - Number of movies of a genre\n');
    fprintf('3 - Number of movies of a genre on a given year\n');
    fprintf('4 - Search movie titles\n');
    fprintf('5 - Search movies based on genres\n');
    fprintf('6 - Exit');
    fprintf('\n---------------------------------\n')
    choice = input('Select choice: ');

    switch choice
        case 1
            fprintf("\n-- List of available genres --\n")
            for i = 1:length(generos)
                fprintf('%d. %s\n', i, generos{i});
            end

            clear i

        case 2
            genre = input('Select a genre: ', 's');
            if verificaGeneroNaLista(genre, generos) == false
                fprintf("\nGénero inválido!")
            else
                n_filmes_genero = bloomFilterCheck(BF_generos,genre,4);
                fprintf('\nNumber of movies in the genre %s: %d\n', genre, n_filmes_genero);
            end

        case 3
             genero_e_ano = input("Select a genre and a year (separated by ','): ","s");
             genero_e_ano = strsplit(genero_e_ano,',');
             if length(genero_e_ano) ~= 2
                fprintf("\nInput inválido!\n")

             else
                 genre = string(genero_e_ano{1});
    
                 year = genero_e_ano{2};
                
                 
                 if verificaGeneroNaLista(genre,generos)==false || str2double(year) < 0 || str2double(year)  > 2023 
                    fprintf("\nInput inválido!")
                
                 else
                    key = strcat(genre,',',year);
                    n_filmes_genero_ano = bloomFilterCheck(BF_generos_ano,key,4);
                    fprintf('\nNumber of movies in the genre %s and from year %d: %d\n', genre, str2double(year),n_filmes_genero_ano);
    
                 end
             end
             

        case 4
            user_string = input("Insert a string: ","s");

            n_hash = 100;
            Set = cell(1,1);
            user_minhash_signature = inf(1,n_hash);

            for i = 1:length(user_string)-1
                Set{1} = [Set{1} convertCharsToStrings(user_string(i:i+1))];
            end
            
            
            for i = 1:length(Set{1})
                key = Set{1}{i}; 
                h_out = muxDJB31MA(key, 127, n_hash);
                user_minhash_signature = min(h_out, user_minhash_signature);
            end 
           
            similarities = zeros(size(assinaturas_opcao4, 1), 1); 
            
            for i = 1:size(assinaturas_opcao4, 1)
                similarities(i) = sum(assinaturas_opcao4(i, :) == user_minhash_signature) / n_hash;
            end

            [sorted_similarities, indices] = sort(similarities,'descend');
            top_5_indices = indices(1:5);
            top_5_similarities = sorted_similarities(1:5);
            
            fprintf('\n--Top 5 similar movie titles--\n');
            for i = 1:length(top_5_indices)
                movieIndex = top_5_indices(i);
                movieTitle = titulos{movieIndex}; 
                movieGenre = generos_totais(movieIndex,1:end);
                similarityScore = top_5_similarities(i);
               
                genresString = '';
                
                for i = 1:length(movieGenre) %#ok
                    
                    if ~ismissing(movieGenre{i})
                        genresString = [genresString, movieGenre{i}, ' - ']; %#ok % Adiciona o género à string de géneros.
                    end
                end
                
                genresString = genresString(1:end-3);
                
                % Print finl
                fprintf('%.2f %s --> %s\n', similarityScore, movieTitle, genresString);

            end


               
        case 5
            continuar = false;
            while ~continuar
                palavras_introduzidas_inicial = input("\nSelect one or more genres (separated by ','): ", "s");
                palavras_introduzidas = strsplit(palavras_introduzidas_inicial, ',');
                for i = 1:length(palavras_introduzidas)
                    if verificaGeneroNaLista(string(strtrim(palavras_introduzidas{i})), generos) == false
                        fprintf('\nOne or more entered genres are not valid. Please try again.\n');
                        continuar = false; 
                        break; 
                    else
                        continuar = true; 
                    end
                end
            end
            
            string_palavras_introduzidas = "";
            for i = 1:length(palavras_introduzidas)
                string_palavras_introduzidas = strcat(string_palavras_introduzidas, palavras_introduzidas{i});
            end
            string_palavras_introduzidas = convertStringsToChars(string_palavras_introduzidas);
            
            n_hash = 100;
            Set = cell(1,1);
            user_minhash_signature = inf(1,n_hash);

            for i = 1:length(string_palavras_introduzidas)-1
                Set{1} = [Set{1} convertCharsToStrings(string_palavras_introduzidas(i:i+1))];
            end
            
            for i = 1:length(Set{1})
                key = Set{1}{i}; 
                h_out = muxDJB31MA(key, 127, n_hash);
                user_minhash_signature = min(h_out, user_minhash_signature);
            end 

            similarities = zeros(size(assinaturas_opcao5, 1), 1);  
            for i = 1:size(assinaturas_opcao5, 1)
                similarities(i) = sum(assinaturas_opcao5(i, :) == user_minhash_signature) / n_hash;
            end
                    
            [sorted_similarities, indices] = sort(similarities,'descend');
            top_5_indices = indices(1:5);
            top_5_similarities = sorted_similarities(1:5);

            ordenados = cell(5,3);

            for i = 1:length(top_5_indices)
                movieIndex = top_5_indices(i);

                ordenados{i, 1} = titulos{movieIndex}; %Título do filme
                          
                ordenados{i, 2} = top_5_similarities(i); %Similaridade
            
                ordenados{i, 3} = anos{movieIndex}; %Ano do filme
            end

            ordenados=sortrows(ordenados, [2,3], 'descend');
             fprintf('\n--Top 5 similar movie based on genres: %s--\n',palavras_introduzidas_inicial);
            for i = 1:5
                fprintf('%.2f %s --> %d\n', ordenados{i,2}, ordenados{i,1}, ordenados{i,3})
            end
            
        case 6
            fprintf('Exiting the application.\n');
        otherwise
            fprintf('Invalid choice. Please select again.\n');
    end
end





