%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao predicado filho: Filho,Pai -> {V,F,D}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido

+filho( F,P ) :: (solucoes( (F,P),(filho( F,P )),S ),
                  comprimento( S,N ), 
				  N == 1
                  ).

% Invariante Referencial: nao admitir mais que 2 progenitores
%                         para um mesmo individuo

+filho( F,P ) :: (solucoes( P,(filho( F,P )),S ),
                  comprimento( S,N ), 
				  N =< 2
                  ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extens�o predicado que permite a evolucao conhecimento

evolucao( Termo ) :- solucoes(Invariante, +Termo::Invariante, Lista),
                     insercao(Termo),
                     teste(Lista).

insercao(Termo):- assert(Termo),assert(Termo).
insercao(Termo):- retract(Termo),!,fail.

teste([]).
teste([R|Lr]):- R,teste(Lr).

solucoes(X,P,S):- findall(X,P,S).

comprimentos(S,N):- length(S,N).


%--------------------------------------------------------------------
Involucao(Termo):- solucoes(Invariante,-Termo::Invariante,Lista),
		           remocao(Termo),
                   teste(Lista).

remocao(Termo):- retract(Termo).
remocao(Termo):- assert(Termo),!,fail.

