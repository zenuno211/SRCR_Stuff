%extra)
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :- Questao, !, fail.
nao( Questao ).


%i) Construa a extensão de um predicado capaz de caracterizar os números pares.
% Extensao do predicado par: N -> {V,F}

par( 0 ).
par( X ) :- N is X-2, N >= 0, par( N ).
	
%par(N):- N mod 2 =:= 0.

%ii) Construa a extensão de um predicado capaz de caracterizar os números ímpares.
% Extensao do predicado impar: N -> {V,F}

impar( 1 ).
impar( X ) :- N is X-2, N >= 1, impar( N ).

%impar(N):- N mod 2 =:= 1.


%iii) Construa a extensão de um predicado que caracterize os números naturais (N).


%iv) Construa a extensão de um predicado que caracterize os números inteiros (Z).


%v) Construa a extensão de um predicado que determine os divisores de um número natural.
divisores( X,NL ) :- XX is X // 2, divisores( X,XX,[1],NL ).

divisores( X,1,[H|T],[H|T] ).
divisores( X,Y,[H|T],[Y|L] ) :- Y > 1, X mod Y =:= 0, YY is Y-1, divisores( X,YY,[H|T],L ).	
divisores( X,Y,[H|T],L ) :- Y > 1, X mod Y =\= 0, YY is Y-1, divisores( X,YY,[H|T],L ). 

%vi) Construa a extensão de um predicado que verifica se um número natural é primo.

primo (X) :- divisores(X,Y), length(Y,1). 



%vii) O cálculo do máximo divisor comum (m.d.c.):
mdc(A,B,R) :- A>B, A1 is A-B, mdc(A1,B,R).
mdc(A,B,R) :- A<B, B1 is B-A, mdc(A,B1,R).
mdc(A,A,A).


%vii)


%ix) fibonacci
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F) :- 
N>1, 
N1 is N-1, fibonacci(N1,F1), 
N2 is N-2, fibonacci(N2,F2), 
F is F1 + F2.










