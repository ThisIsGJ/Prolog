%test([[1,1,1,1],[2,2,2,2],[2,2,2,2],[3,3,3,3],[7,7,7,7]],[],R).
deletePartProduct([[_,_,_,D]|T],L,R):-	
		member([_,_,_,D],T),
		deleteDuplicateNum(D,T,[],Tnew),
		deletePartProduct(Tnew,L,R).
					
deletePartProduct([[A,B,C,D]|T],L,R):-	
		not(member([_,_,_,D],T)),
		app([[A,B,C,D]],L,Lnew),
		deletePartProduct(T,Lnew,R).									
deletePartProduct([],Ls,Ls).									


deleteDuplicateNum(N,[[_,_,_,D]|T],L,R):-
		N=:=D,
		deleteDuplicateNum(N,T,L,R).
deleteDuplicateNum(N,[[A,B,C,D]|T],L,R):-
		N=\=D,
		app([[A,B,C,D]],L,Lnew),
		deleteDuplicateNum(N,T,Lnew,R).
deleteDuplicateNum(_,[],L,L).		
		

quicksort2([],[]).
quicksort2(List,Sorted)     :- var(List), 
                             !, 
                             perm(Sorted,List),
                             quicksort2(List,Sorted).
quicksort2([X|Tail],Sorted) :- split2(X,Tail,Small,Big),
                             quicksort2(Small,SortedSmall),
                             quicksort2(Big,SortedBig),
                             app(SortedSmall,[X|SortedBig],Sorted).

split2(_,[],[],[]).
split2([A,B,C,D],[[E,F,G,H]|Tail],[[E,F,G,H]|Small],Big)  :- D > H,
                                   !,
                                   split2([A,B,C,D],Tail,Small,Big).
split2( [A,B,C,D],[[E,F,G,H]|Tail],Small,[[E,F,G,H]|Big]) :- split2([A,B,C,D],Tail,Small,Big).

app([],L,L).
app([E|T],L,[E|M]) :- app(T,L,M).

perm([],[]).
perm(X,[E|Y]) :- remove(E,X,Z),
                perm(Z,Y).

member(E,[E|_]).
member(E,[_|R]) :- member(E,R).