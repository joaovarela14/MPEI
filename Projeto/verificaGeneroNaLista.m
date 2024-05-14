function genero_valido = verificaGeneroNaLista(genero, lista_generos)
    genero_valido = any(strcmp(genero, lista_generos));
end