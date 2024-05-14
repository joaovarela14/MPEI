function count = bloomFilterCheck(bloom, key, k)
    m = length(bloom);
    key = convertStringsToChars(key);
    aux = muxDJB31MA(key, 127, k);
    count = [];
    for i = 1:k
        key = [key num2str(i)];
        hash = mod(aux(i), m) + 1;
        if bloom(hash) > 0
            count = [count bloom(hash)];
        end
    end
    count = min(count); %slides
end

