% Função que verifica se um determinado elemento X pertence a uma lista

member(X,[X|_]).
member(X,[_|T]):-member(X,T).

%--------------------------------------------------------------------------
NOTA(Dúvida):

len([],0).
len([_|L],N):-len(L,X),N is X +1.

% Colocar: len([1,2])
% Resultado: 2 (correto)

len1([],0).
len1([_|L],N+1):-len(L,X).

% Colocar: len1([1,2])
% Resultado: N = 0+1+1 (errado)


% A primeira solução (len) é que é a correta, uma vez que a segunda não daria sequer o resultado 
% pretendido. na len1, fará uma concatenação de N com os caracteres +1. 


%--------------------------------------------------------------------------

accMin([H|T],A,Min):- H < A,accMin(T,H,Min).
accMin([H|T],A,Min):- H => A,accMin(T,A,Min).
accMin([],A,A).


