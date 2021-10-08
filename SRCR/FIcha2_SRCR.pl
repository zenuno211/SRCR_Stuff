%----------------------------------------------------------------------------
% Resolução da Ficha 2

%i) 
soma(X,Y,Soma) :- Soma is X+Y.

%ii) 
soma3(X,Y,Z,Som) :- Som is X+Y+Z.

%iii)
somaMuitos([],0).
somaMuitos([H|T],A) :- somaMuitos(T,A1), A is A1+H.

%iv)
operacao(adicao,X,Y,Ad) :- Ad is X+Y.
operacao(subtracao,X,Y,Sub) :- Sub is X-Y.
operacao(divisao,X,Y,Div) :- Y\=0,Div is X/Y.
operacao(multiplicacao,X,Y,Mult) :- Mult is X*Y.

%v)
%operacao(_,[],0).
operacao(adicao,[],0).
operacao(adicao,[C|T],Ad) :- operacao(adicao,T,Ad1), Ad is Ad1+C.

operacao(subtracao,[],0).
operacao(subtracao,[C|T],Sub) :- operacao(subtracao,T,Sub1), Sub is C-Sub1.

operacao(divisao,[],1).
operacao(divisao,[C|T],Div) :- operacao(divisao,T,Div1), Div1\=0, Div is C/Div1.

operacao(multiplicacao,[],1).
operacao(multiplicacao,[C|T],Mult) :- operacao(multiplicacao,T,Mult1) , Mult is Mult1*C.

%vi)
max1(X,Y,X):- X >= Y.
max1(X,Y,Y):- X < Y.
%ou de uma melhor forma (correta) que evita caminhos alternativos:
max2(X,Y,X):- X >= Y,!.
max2(X,Y,Y):- X < Y.


%vii)
maximo3(X,Y,Z,Var):- max2(X,Y,Var1), max2(Z,Var1,Var).

%viii)
% DUVIDA: Como fazer???
% maximoconj([H|C|T],max) :- maximoconj([C|T],Var1), max2(H,Var1,max).

%xii)
comprimento([],0).
comprimento([H|T],Comp) :- comprimento(T,Comp1), Comp is Comp1+1.

media([C|T],Med):- somaMuitos([C|T],ST), comprimento([C|T],Comp), Med is ST/Comp.


% ACABAR AS ULTIMAS!!!!!!!!!!!!!!!!!!!!!
