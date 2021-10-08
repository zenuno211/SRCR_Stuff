%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic jogo/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado jogo: Jogo,Arbitro,Ajudas -> {V,F,D}

-jogo( Jogo,Arbitro,Ajudas ) :-
    nao( jogo( Jogo,Arbitro,Ajudas ) ),
    nao( excecao( jogo( Jogo,Arbitro,Ajudas ) ) ).

%i)
jogo( 1,Almeida Antunes,500 ).

%ii) Conhecimento incerto
jogo( 2,Baltazar Borges,desc ).

excecao( jogo( Jogo,Arbitro,Ajudas ) ) :-
    jogo( Jogo,Arbitro,desc ).

%iii) Conhecimento impreciso
excecao(jog(3,Costa Carvalho,500)).
excecao(jogo(3,Costa Carvalho,2500)).

%iv) Conhecimento impreciso
jogo( 2,Baltazar Borges,desc ).

excecao( jogo( 4,Duarte Durão,Valor ) ) :-
    Valor>=250,Valor=<750.

%v) Conhecimento interdito
jogo( 5, Edgar Esteves, QQ).

excecao(jogo(Jogo,Arbitro,Ajudas)):-
    jogo(Jogo, Arbitro, QQ).

nulo(QQ).

+jogo(J,A,C):-(solucoes(Ajudas,(jogo(5,Edgar Esteves,Ajudas),nao(nulo(Ajudas))),S),comprimento(S,N),N==0).

%vi) Conhecimento impreciso
jogo(6,ff,250).

excecao(jogo(6,ff,Ajudas)):-Ajudas>=5000.

%vii) Conhecimento negativo e Conhecimento incerto
-jogo(7,gg,2500)

jogo(7,gg,Unknown).
excecao(jogo(Jogo,Arbitro,Ajudas)):-jogo(Jogo,Arbitro,Unknown).

%viii)
excecao(jogo(8,hh,Ajudas)):-
    cerca(1000,Csup,Cinf),
    Ajudas>=Cinf, ajudas =<Csup.

cerca(X,Sup,Inf):-
    Sup is X*1.25,
    Inf is X*0.75.

%ix)
excecao(jogo(9,ii,Ajudas)):-
    cerca(3000,Csup,Cinf),
    Ajudas>=Cinf, ajudas =<Csup.


%---------------------------------------------------------------------
%x)
+jogo(J,A,C) :: (solucoes(Arbitro,(jogo(Jogo,Arbitro,Ajudas)),S),
    comprimento(S,N),
    N==1). 


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :-
    assert( Termo ),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).

