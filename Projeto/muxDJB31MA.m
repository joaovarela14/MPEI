function aux = muxDJB31MA(chave, seed, k)
    len = length(chave);
    chave = double(chave);
    h = seed;
    aux = zeros(1, k);
    for i=1:len
        h = mod(31 * h + chave(i), 2^32 -1) ;
    end
    for i = 1:k
        h = mod(31 * h + i, 2^32 -1) ;
        aux(i) = h;
    end
end