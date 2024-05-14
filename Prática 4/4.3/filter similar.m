function SimilarUsers = filter_similar(users,J)
    Nu = length(users);
    tic;
    threshold = 0.4; 
    h= waitbar(0,'Espera sentadinho - Filtrando');
    SimilarUsers= zeros(1,3);
    k= 1;
    for n1= 1:Nu
        waitbar(n1/Nu,h);
        for n2= n1+1:Nu
            if J(n1,n2)<threshold
                SimilarUsers(k,:)= [users(n1) users(n2) J(n1,n2)];
                k= k+1;
            end
        end
    end
    delete (h);
    fprintf("time to filter similar: %7.6es\n",toc);

end