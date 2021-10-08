%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- dynamic '-'/1.
:- dynamic mamifero/1.
:- dynamic morcego/1.



%--------------------------------- - - - - - - - - - -  -  -  -  -   -

voa( X ) :- ave( X ), nao(excecao(voa(X))).
-voa( tweety ). //quer dizer que não voa o tweety
-voa( X ) :- mamifero( X ), nao(excecao(-voa(X))).

excecao( voa(X)):-avestruz(X).
excecao(-voa(X)):-morcego(X).

ave(Pitigui).
ave(X) :- canario(X).
ave(X) :- periquito(X).
canario(Piupiu).
mamifero(Silvestre).
cao(X) :- mamifero(X).



si( Questao,verdadeiro ) :- Questao.
si( Questao,falso ) :- -Questao.
si( Questao,desconhecido ) :- nao( Questao ), nao( -Questao ).
	
	
	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).
