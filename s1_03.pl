getLL(Max,R):-
		getPossibleNum(Max,Lp),
		toGetLL(Max,Lp,R).



toGetLL(Max,L,R):- 
		getLLList(Max,L,L,[],R).
	

getLLList(Max,[],L1,L2,L2).
getLLList(Max,[H|T],L1,L2,R):- 
		getEachL(Max,H,L1,[],Lnew),
		app(Lnew,L2,L2new),
		getLLList(Max,T,L1,L2new,R).		

getEachL(Max,E,[],L,L).
getEachL(Max,E,[H|T],L,R):-
		E=<H,
		E+H=<Max,
		%not(isPrime(E,2)),!!!!!!!!!
		%not(isPrime(H,2)),
		not(testP2(E,H)),					%cannot have 2^11
		not(E*E=:=H),      					%cannot p*p*p such as 2*2*2=2*4=8	
		Sum is E+H,
		Product is E*H,
		app([[E,H,Sum,Product]],L,Lnew),
		getEachL(Max,E,T,Lnew,R).	

getEachL(Max,E,[H|T],L,R):-
		isPrime(E,2),
		isPrime(H,2),
		getEachL(Max,E,T,L,R).					
getEachL(Max,E,[H|T],L,R):-
		E>H,
		%E+H=<Max,!!!!!!!!!!
		getEachL(Max,E,T,L,R).					
getEachL(Max,E,[H|T],L,R):-
		testP2(E,H),						%cannot have 2^11     					
		getEachL(Max,E,T,L,R).	
getEachL(Max,E,[H|T],L,R):-
		E*E=:=H,      						%cannot p*p*p such as 2*2*2=2*4=8					 					
		getEachL(Max,E,T,L,R).	
getEachL(Max,E,[H|T],L,L):-
		E+H>Max.						


testP2(E,H):-
		E*H=:=2048,
		E+H=:=96.

getPossibleNum(Max,R):-
		Maxnew is Max-2,
		getPrimeList(Maxnew,LPrime),
		getDeleteP(Maxnew,LPrime,[],L),
		setTheNum(Maxnew,Maxnew,L,[],R).


getDeleteP(Max,[H|T],L,R):-
		H>=Max/2,
		getDeleteP(Max,T,[H|L],R).
getDeleteP(Max,[H|T],L,R):-
		H<Max/2,
		getDeleteP(Max,T,L,R).
getDeleteP(Max,[],L,L).				


setTheNum(2,Max,[],L,L).				
setTheNum(N,Max,[],L,R):-
		N>2,
		Nnew is N-1,
		setTheNum(Nnew,Max,[],[N|L],R).	
setTheNum(N,Max,[H|T],L,R):-		
		N>2,
		N=\=H,
		Nnew is N-1,
		setTheNum(Nnew,Max,[H|T],[N|L],R).
setTheNum(N,Max,[H|T],L,R):-		
		N>2,
		N=:=H,
		Nnew is N-1,
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

app([],L,L).
app([E|T],L,[E|M]) :- app(T,L,M).		