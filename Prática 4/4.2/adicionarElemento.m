function similarity = ComputeGenresSimilarity(input_values, genre_signatures, movie_years)
    k = width(genre_signatures);
    input_signature = CalculateSingleSignature(input_values, k);
    similarity = zeros(k,3);
    for i = 1:height(genre_signatures)
        sig1 = genre_signatures(i, :);
        similarity(i,1) = i;
        similarity(i,2) = sum(sig1 == input_signature) / k;
        similarity(i,3) = movie_years{i};
    end
    similarity = sortrows(similarity, [2,3], 'descend');
    similarity = similarity(1:5, :);
end