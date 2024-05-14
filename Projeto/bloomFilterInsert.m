function bloom = bloomFilterInsert(bloom, key, k)
    m = length(bloom);
    aux = muxDJB31MA(key, 127, k);
    for i = 1:k
        key = [key num2str(i)];
        hash = mod(aux(i), m) + 1;
        bloom(hash) = bloom(hash) + 1;
    end
end
