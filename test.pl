getPP(Max,R):-
		getPrimeList(Max,L),				%get all the prime which is less than 100	
		Maxnew is (Max/2-1)*(Max/2+1),
		getPPList(Maxnew,L,L,[],R).			%get all the number which is prime*prime

		
			
									
%get all the number which is prime*prime

		

	
%[H|T] 提取prime L1用来被乘以的所有primeList L2用来储存List	
getPPList(Max,[],L1,L2,L2).
getPPList(Max,[H|T],L1,L2,R):- 
		getEachPP(Max,H,L1,[],Lnew),
		app(Lnew,L2,L2new),
		getPPList(Max,T,L1,L2new,R).		
		
%提出一个prime和所有prime相乘得到一个list				
getEachPP(Max,E,[H|T],L,R):-
		E=<H,
		Product is E*H,
		Product=<Max,		
		app([Product],L,Lnew),
		getEachPP(Max,E,T,Lnew,R).	
getEachPP(Max,E,[H|T],L,R):-
		E>H,
		E*H=<Max,		
		getEachPP(Max,E,T,L,R).			
getEachPP(Max,E,[H|T],L,L):-
		E*H>Max.
getEachPP(Max,E,[],L,L).	

%get all the prime number which < 100
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

%delete all the number which is not prime
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

deleteNotPrime(_,[],L,L).
		
%reverse the list
rev(L,R):-  theRev(L,[],R).
theRev([],A,A).
theRev([H|T],A,R):-  theRev(T,[H|A],R). 

%test if the number is prime
isPrime(X,X).
isPrime(X,Y):-
		Y<X,
		0 =\= X mod Y,
		Ynew is Y+1,
		isPrime(X,Ynew).
			
%quick sort the list
quicksort([],[]).
quicksort(List,Sorted)     :- var(List), 
                             !, 
                             perm(Sorted,List),
                             quicksort(List,Sorted).
quicksort([X|Tail],Sorted) :- toSplit(X,Tail,Small,Big),
                             quicksort(Small,SortedSmall),
                             quicksort(Big,SortedBig),
                             app(SortedSmall,[X|SortedBig],Sorted).

toSplit(_,[],[],[]).
toSplit(X,[Y|Tail],[Y|Small],Big)  :- X > Y,
                                   !,
                                   toSplit(X,Tail,Small,Big).
toSplit( X,[Y|Tail],Small,[Y|Big]) :- toSplit(X,Tail,Small,Big).

app([],L,L).
app([E|T],L,[E|M]) :- app(T,L,M).

perm([],[]).
perm(X,[E|Y]) :- remove(E,X,Z),
                perm(Z,Y).

remove(X,[X|R],R).
remove(X,[E|R],[E|T]) :- remove(X,R,T).	
		