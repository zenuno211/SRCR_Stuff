%problema de estado único com estado inicial s
% no entanto se não fosse determinado que s era o inicial, era um problema de estado múltiplo

%auxiliares----------------------------------------
nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).

inverso(Xs,Ys):-inverso(Xs,[], Ys).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [Y|Ys]):- seleciona(E, Xs, Ys).

%--------------------------------------------------

aresta(s,a,2). 
aresta(a,b,2).
aresta(b,c,2).
aresta(c,d,3).
aresta(d,t,3).
aresta(s,e,2).
aresta(e,f,5).
aresta(f,g,2).
aresta(g,t,2).
%aresta(s,d,6).
%aresta(c,t,2).
aresta(b,f,2).

estima(a,5).
estima(b,4).
estima(c,4).
estima(d,3).
estima(e,7).
estima(f,4).
estima(g,2).
estima(s,10).
estima(t,0).


adjacente(Nodo,ProxNodo):-aresta(Nodo,ProxNodo,_).
adjacente(Nodo,ProxNodo):-aresta(ProxNodo,Nodo,_).


goal(t).


%em profundidade mas estado unico
resolve_pp(Nodo,[Nodo|Caminho]):-
        profundidadeprimeiro1(Nodo,[Nodo],Caminho).

profundidadeprimeiro1(Nodo,_,[]):-goal(Nodo).
profundidadeprimeiro1(Nodo,Historico,[ProxNodo|Caminho]):-
        adjacente(Nodo,ProxNodo),
        nao(membro(ProxNodo,Historico)),
        profundidadeprimeiro1(ProxNodo,[ProxNodo|Historico],Caminho).


%em profundidade multi estados----------------------------------------------------------------------------------------------------------------------------- 
resolve_pp_todos(Origem,Destino,Caminho):-
        profundidade(Origem,Destino,[Origem],Caminho).

profundidade(Destino,Destino,H,D):- reverse(H,D).
profundidade(Origem,Destino,Historico,C):-
        adjacente(Origem,ProxNodo),
        nao(membro(ProxNodo,Historico)),
        profundidade(ProxNodo,Destino,[ProxNodo|Historico],c).


resolve_pp_h(NodoInicial, NodoFinal, Caminho):-
    profundidade(NodoInicial, NodoFinal, [NodoInicial], Caminho).

profundidade(Destino,Destino,H,D):- reverse(H,D).
profundidade(Origem, Destino, Historico, C):-
    adjacente(Origem,Prox),
    nao(membro(Prox,Historico)),
    profundidade(Prox,Destino, [Prox|Historico], C).


melhor(Nodo,Cam,Custo):-findall((Ca, Cus), resolve_pp_todos(Nodo, Ca, Cu), L), minimo(L,(Cam,Custo)).

%falta o minimo
minimo([(P,X)],(P,X)).
minimo([(Px,X)|L],(Py,Y)):- minimo(L,(Py,Y)), X>Y.
minimo([(Px,X)|L],(Py,Y)):- minimo(L,(Py,Y)), X=<Y.



%em profundidade estado unico com calculo de custo---------------------------------------------------------------------------------------------------
resolve_pp_custo(Inicio,[Inicio],Custo):-
        profundidadecusto(Inicio,[Inicio],Custo).

profundidadecusto(Inicio,_,0):-goal(Inicio).
profundidadecusto(Inicio,Historico,Custo):-
        adjacentecusto(Inicio,ProxNodo,C1),
        nao(membro(ProxNodo,Historico)),
        profundidadecusto(ProxNodo,[ProxNodo|Historico],C2),
        Custo is C1 + C2.


adjacentecusto(Nodo,ProxNodo,C):-aresta(Nodo,ProxNodo,C).
adjacentecusto(Nodo,ProxNodo,C):-aresta(ProxNodo,Nodo,C).


%gulosa------------------------------------------------------------------------------------------------------------------------------------------------
resolve_gulosa(Nodo,Caminho/Custo):-
        estima(Nodo,Estima),
        agulosa([[Nodo]/0/Estima], InvCaminho/Custo/_), reverse(InvCaminho,Caminho).


agulosa(Caminhos, Caminho):- obtem_melhor_g(Caminhos, Caminho),
                             Caminho = [Nodo|_]/_/_,goal(Nodo).

agulosa(Caminhos,SolucaoCaminho):-
        obtem_melhor_g(Caminhos,MelhorCaminho),
        seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
        expande_gulosa(MelhorCaminho,ExpCaminhos),
        append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
        agulosa(NovoCaminhos,SolucaoCaminho).

obtem_melhor_g([Caminho],Caminho):-!.

obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho):- 
        Est1 =< Est2,!,
        obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).

obtem_melhor_g([_|Caminhos], MelhorCaminho):-
        obtem_melhor_g(Caminhos,MelhorCaminho).

expande_gulosa(Caminho, ExpCaminhos):-
        findall(NovoCaminho,adjacente3(Caminho,NovoCaminho), ExpCaminhos).


adjacente3([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est):-
        aresta(Nodo, ProxNodo, PassoCusto), \+ member(ProxNodo,Caminho),
        NovoCusto is Custo + PassoCusto,
        estima(ProxNodo,Est).


%A* -----------------------------------------------------------------------------------------------------------------------------------------------------

resolve_estrela(Nodo,Caminho/Custo):-
        estima(Nodo,Estima),
        aestrela([[Nodo]/0/Estima], InvCaminho/Custo/_), reverse(InvCaminho,Caminho).


aestrela(Caminhos, Caminho):- obtem_melhor_g_estrela(Caminhos, Caminho),
                             Caminho = [Nodo|_]/_/_,goal(Nodo).

aestrela(Caminhos,SolucaoCaminho):-
        obtem_melhor_g_estrela(Caminhos,MelhorCaminho),
        seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
        expande_estrela(MelhorCaminho,ExpCaminhos),
        append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
        aestrela(NovoCaminhos,SolucaoCaminho).

obtem_melhor_g_estrela([Caminho],Caminho):-!.

obtem_melhor_g_estrela([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho):- 
        Est1 + Custo1 =< Est2 + Custo2,!,
        obtem_melhor_g_estrela([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).

obtem_melhor_g_estrela([_|Caminhos], MelhorCaminho):-
        obtem_melhor_g_estrela(Caminhos,MelhorCaminho).

expande_estrela(Caminho, ExpCaminhos):-
        findall(NovoCaminho,adjacente3(Caminho,NovoCaminho), ExpCaminhos).

