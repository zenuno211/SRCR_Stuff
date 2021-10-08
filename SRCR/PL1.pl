%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F}

%i)
filho(joao,jose).

%ii)
filho(jose,manuel).

%iii)
filho(carlos,jose).

% Para testar
filho(maria,paulo).
filho(paulo,joca).
filho(joca,joaquim).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

%iv)
pai(paulo,filipe).

%v)
pai(paulo,maria).

pai(joca,paulo).

pai(joaquim,joca).

%xii)
pai(P,F) :- filho(F,P).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

%vi)
avo(antonio,nadia).

%xiii) -> uma das duas mas melhor colocar tudo em relação ao filho
% avo(A,N) :- filho(N,P), filho(P,A).
% avo(A,N) :- pai(P,N), pai(A,P).

%xvii)
avo(A,N) :- descendente(N,A,2).

%----------------------------------------------------------------------
% Extensao do predicado neto: Neto,Avo -> {V,F}

%vii)
neto(nuno,ana).

%xiv)
neto(N,A) :- filho(N,P), filho (P,A).

%-----------------------------------------------------------------------

%viii)
sexo(m,joao).

%ix)
sexo(m,jose).

%x)
sexo(f,maria).

%xi)
sexo(f,joana).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: Bisavo,Bisneto -> {V,F}

%xviii)
bisavo(B,N) :- descendente(N,B,3).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado trisavo: trisavo,trineto -> {V,F}

%xix)
trisavo(T,N) :- descendente(N,T,4).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado tetraneto: tetraneto,tetravo -> {V,F}

%xx)
tetraneto(N,T) :- descendente(N,T,4).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}

%xv)
descendente(D,A) :- filho(D,A).  
descendente(D,A) :- filho(D,X), descendente(X,A).

% acima temos um exemplo de recursividade 


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

%xvi)
descendente(D,A,1) :- filho(D,A).
descendente(D,A,G) :- filho(D,X), descendente(X,A,N), G is N+1. 



