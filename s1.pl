%显得到所有小于100的质数，然后设置list从2到98，一一对应，是质数的就不加入list，不是质数就加入list
getS1Result(Max,R):-
		Maxnew is Max-2,
		Maxnew2 is Max-1,
		getPrimeList(Maxnew,PrimeList),		
		getTheResult(2,PrimeList,[],R,Maxnew2).%get the prime list

getTheResult(Max,[],L,L,Max).
getTheResult(N,[],L,R,Max):-			%put the rest number into the list
		N=<Max,
		Nnew is N+1,
		getTheResult(Nnew,[],[N|L],R,Max).
			
getTheResult(N,[H|T],L,R,Max):-			%put the number which is not prime into the list
		N<Max,
		Nnew is N+1,
		N =\= H,
		getTheResult(Nnew,[H|T],[N|L],R,Max).
		
getTheResult(N,[H|T],L,R,Max):- 		%do not put the prime number into the list
		N<Max,
		Nnew is N+1,
		N =:= H,
		getTheResult(Nnew,T,L,R,Max).		

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