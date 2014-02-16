s1(Q,Max):-
		Maxnew is Max-1,
		getPrimeList(Maxnew,LPrime),			%small -> big
		setTheNum(2,Maxnew,LPrime,[],L1),		%all possible number except prime number big->smmal
		toGetLL(Max,L1,L1new),					%not p* not p
		quicksort(L1new,Q).

toGetLL(Max,L,R):- 
		rev(L,Lnew),
		getLLList(Max,Lnew,Lnew,[],R).
	

getLLList(Max,[],L1,L2,L2).
getLLList(Max,[H|T],L1,L2,R):- 
		getEachL(Max,H,L1,[],Lnew),
		app(Lnew,L2,L2new),
		getLLList(Max,T,L1,L2new,R).		

getEachL(Max,E,[],L,L).
getEachL(Max,E,[H|T],L,R):-
		E=<H,
		E+H=<Max,
		not(testP2(E,H)),					%cannot have 2^11
		Sum is E+H,
		Product is E*H,
		app([[E,H,Sum,Product]],L,Lnew),
		getEachL(Max,E,T,Lnew,R).	
					
getEachL(Max,E,[H|T],L,R):-
		E>H,
		E+H=<Max,
		getEachL(Max,E,T,L,R).					
getEachL(Max,E,[H|T],L,R):-
		testP2(E,H),						%cannot have 2^11     					
		getEachL(Max,E,T,L,R).	
getEachL(Max,E,[H|T],L,R):-
		E*E=:=H, 
		%E+H=<Max,     						%cannot p*p*p such as 2*2*2=2*4=8					 					
		getEachL(Max,E,T,L,R).	
getEachL(Max,E,[H|T],L,L):-
		E+H>Max.						

testP2(E,H):-
		E*H=:=2048,
		E+H=:=96.										


setTheNum(Max,Max,[],L,L).				
setTheNum(N,Max,[],L,R):-
		N<Max,
		Nnew is N+1,
		setTheNum(Nnew,Max,[],[N|L],R).	
setTheNum(N,Max,[H|T],L,R):-		
		N<Max,
		N=\=H,
		Nnew is N+1,
		setTheNum(Nnew,Max,[H|T],[N|L],R).
setTheNum(N,Max,[H|T],L,R):-		
		N<Max,
		N=:=H,
		Nnew is N+1,
		setTheNum(Nnew,Max,T,L,R).		
		
		

getPrimeList(Max,R):-setList(Max,[],R,Max).
setList(1,L,R,Max):-setPrimeNumber(2,L,R,Max).
setList(N,L,R,Max):- 
		N>1,
		Nnew is N-1,
		setList(Nnew,[N|L],R,Max).

setPrimeNumber(Prime,L,R,Max):-
		Prime=<sqrt(Max),
		isPrime(Prime,2),		
		deleteNum(Prime,L,Lnew),
		PrimeNew is Prime+1,		
		setPrimeNumber(PrimeNew,Lnew,R,Max).
		
setPrimeNumber(Prime,L,R,Max):-
		Prime=<sqrt(Max),
		not(isPrime(Prime,2)),
		PrimeNew is Prime+1,
		setPrimeNumber(PrimeNew,L,R,Max).

setPrimeNumber(Prime,L,L,Max):-
		Prime>sqrt(Max).
				
deleteNum(Prime,L,R):- deleteNotPrime(Prime,L,[],R).
deleteNotPrime(Prime,[H|T],L,R):-
		H =\= Prime,
		H mod Prime =:= 0,
		deleteNotPrime(Prime,T,L,R).
			
deleteNotPrime(Prime,[H|T],L,R):-
		H =:= Prime,
		deleteNotPrime(Prime,T,[H|L],R).
		
deleteNotPrime(Prime,[H|T],L,R):-
		H mod Prime =\= 0,
		deleteNotPrime(Prime,T,[H|L],R).

deleteNotPrime(_,[],L,R):-
		rev(L,R).
					
rev(L,R):-  theRev(L,[],R).
theRev([],A,A).
theRev([H|T],A,R):-  theRev(T,[H|A],R). 
		
isPrime(X,X).
isPrime(X,Y):-
		Y<X,
		0 =\= X mod Y,
		Ynew is Y+1,
		isPrime(X,Ynew).	

quicksort([],[]).
quicksort(List,Sorted)     :- var(List), 
                             !, 
                             perm(Sorted,List),
                             quicksort(List,Sorted).
quicksort([X|Tail],Sorted) :- split(X,Tail,Small,Big),
                             quicksort(Small,SortedSmall),
                             quicksort(Big,SortedBig),
                             app(SortedSmall,[X|SortedBig],Sorted).

split(_,[],[],[]).
split([A,B,X,D],[[E,F,Y,G]|Tail],[[E,F,Y,G]|Small],Big)  :- X > Y,
                                   !,
                                   split([A,B,X,D],Tail,Small,Big).
split( [A,B,X,D],[[E,F,Y,G]|Tail],Small,[[E,F,Y,G]|Big]) :- split([A,B,X,D],Tail,Small,Big).

app([],L,L).
app([E|T],L,[E|M]) :- app(T,L,M).

perm([],[]).
perm(X,[E|Y]) :- remove(E,X,Z),
                perm(Z,Y).

remove(X,[X|R],R).
remove(X,[E|R],[E|T]) :- remove(X,R,T).	