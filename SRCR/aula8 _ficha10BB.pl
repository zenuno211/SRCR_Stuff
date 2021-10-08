%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Resolucaoo de problemas de pesquisa (Ficha 10)


%---------------------------------  dados do problema ---------

%alinea a)
% É um problema de estado único que depende apenas do estado inicial, 
% neste problema vou avançando de estado para estado

%alinea b)(resumo)
% estado inicial -> ambos os valdes se encontram vazios
% estados finais: o jarro de 8 litros ter apenas 4 ou o jarro de 5 litros ter apenas 4
% estado objetivo -> pelo menos um dos baldes com 4 litros
% operação 1: (encher um dos jarros com água do tanque)
% 		pre-condição: o jarro a ser enchido não estar cheio 
% operação 2: (esvaziar um dos jarros para o tanque)
% operação 3: (transferir o conteúdo de um jarro para o outro, até que o primeiro se esvazie
% completamente ou o outro atinja a sua capacidade máxima)
% cada acao custa uma unidade



% estado inicial ->(jarros vazios)
inicial(jarros(0, 0)).

% estados finais->(Pelo menos um dos baldes tem 4)
final(jarros(4, _)).
final(jarros(_, 4)).


% transicoes possiveis transicao: EixOpXEf ->Teremos cerca de 6 operações diferentes


% encher o vaso 1(8 litros)
transicao(jarros(V1, V2), encher(1), jarros(8, V2)):- V1 < 8.

%encher o vaso 2 (5 litros)
transicao(jarros(V1, V2), encher(2), jarros(V1, 5)):- V2 < 5.

%esvaziar o vaso 1 para o tanque
transicao(jarros(V1, V2), esvaziar(1), jarros(0, V2)):- V1 > 0.

%esvaziar o vaso 2 para o tanque
transicao(jarros(V1, V2), esvaziar(2), jarros(V1, 0)):- V2 > 0.

%passar do vaso 2 para o vaso 1
transicao(jarros(V1,V2), encher(2,1), jarros(NV1,Nv2)):-
	V2 > 0,
	NV2 is max(V2 -8 + V1,0),
	NV2 < V2
	NV1 is V1 + V2 - NV2.

%passar do vaso 1 para o vaso 2
transicao(jarros(V1, V2), encher(1, 2), jarros(NV1, NV2)):- 
	V1 > 0,
	NV1 is max(V1 - 5 + V2, 0), 
	NV1 < V1, 
	NV2 is V2 + V1 - NV1.

% --------------------------------------------------------------------------------------------
%profundidade
resolvedf(Solucao):- inicial(InicialEstado),
					 resolvedf(InicialEstado, [InicialEstado], Solucao),
					 escreveLista(Solucao).
					
resolvedf(Estado,_,[]):- final(Estado),!.

resolvedf(Estado,Historico,[Move|Solucao]):- transicao(Estado,Move,Estado1),
											 nao(membro(Estado1,Historico)),
											 resolvedf(Estado1,[Estado1|Historico],Solucao).


escreveLista([H|T]):- write(H),nl,escreveLista(T).


todos(L):-findall((S,C), (resolvedf(S), length(S,C)), L), minimo(L,(S,Custo)). %dá o melhor caminho de todos

minimo([(P,X)],(P,X)).
minimo([(Px,X)|L],(Py,Y)):- minimo(L,(Py,Y)), X>Y.
minimo([(Px,X)|L],(Py,Y)):- minimo(L,(Py,Y)), X=<Y.

%largura
resolvebf(solucao):- inicial(InicialEstado),
					 resolvebf([(InicialEstado, [])|Xs]-Xs, [], Solucao).
resolvebf([(Estado,Vs)|_]-_,_,Rs):- final(Estado),!,inverso(Vs,Rs).
resolvebf([(Estado,_)|Xs]-Ys,Historico,Solucao):- membro(Estado,Historico),!, resolvebf(Xs-Ys, Historico, Solucao).
resolvebf([(Estado,Vs)|Xs]-Ys, Historico,Solucao):- 
		setof((Move, Estado1), transicao(Estado,Move,Estado1),Ls),
		atualizar(Ls, Vs, [Estado|Historico],Ys-Zs),
		resolvebf(Xs-Zs, [Estado|Historico],Solucao).

atualizar([],_.X-X).
atualizar([(__, Estado)|Ls], Vs, Historico, Xs-Ys):- membro(Estado,Historico),!, atualizar(Ls, Vs, Historico, Xs-Ys).
atualizar([(Move,Estado)|Ls], Vs, Historico, [(Estado,[Move|Vs])|Xs]-Ys):-atualizar(Ls,Vs,Historico,Xs-Ys).





nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).


