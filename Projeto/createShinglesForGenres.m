function [Set] = createShinglesForGenres(generos_totais)
    Set = cell(size(generos_totais, 1), 1);

    for n = 1:size(generos_totais, 1)
        genreString = '';  
        
        % Concatena todos os géneros válidos do filme n em uma única string
        for j = 1:size(generos_totais, 2)
            if isa(generos_totais{n,j}, 'char') 
                genreString = [genreString, generos_totais{n,j}];  
            end
        end
        
        % Cria shingles para todos os géneros concatenados
        shingles = {};
        for i = 1:length(genreString)-1
            shingle = genreString(i:i+1);
            shingles{end+1} = shingle;
        end
        
        Set{n} = shingles;
    end
end
