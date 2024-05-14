function [Set] = createShinglesTitle(titulos)
   
    n_titulos = length(titulos);
    Set = cell(n_titulos,1);

    for n = 1:n_titulos
        title = titulos{n};
        for i = 1:length(title)-1
            Set{n} = [Set{n} convertCharsToStrings(title(i:i+1))];
        end
    end
end
