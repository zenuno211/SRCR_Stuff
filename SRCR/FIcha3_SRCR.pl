%------------------------------[Ficha 3]-----------------------------------------
%Resolução da ficha 3


%i)
member(X,[X|_]).
member(X,[_|T]):-member(X,T).

%ii)
comprimento([],0).
comprimento([H|T],Comp) :- comprimento(T, Comp1), Comp is Comp1+1.

%iii)
diferentes([],0).
diferentes([X|L],N) :-  member(X,L), quantos(L,N).
diferentes([X|L],N1) :-  quantos(L,N), N1 is N+1.

%iv)
apagar(X,[X|R],R).
apagar(X,[Y|R],[Y|L]) :-  X\=Y, apagar(X,R,L).

%v)
apagaTudo(X,[],[]).
apagaTudo(X,[X|R],L) :- apagaTudo (X,R,L).
apagaTudo(X,[Y|R],[Y|L]):- X\= Y. %faltaqualquercoisa
