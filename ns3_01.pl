%The right s2
test(Max,L):-
	s3(Q,Max),
	getn(Q,0,L).
	
getn([_|T],R,N):-
	Rnew is R+1,
	getn(T,Rnew,N).
getn([],R,R).

s3(Q,Max):-
		s2(S2Result,Max),
		getSingleProduct(S2Result,[],Result),
		merge_sort2(Result,Q).

aa([H|T],L,R):- 
		T = [],
		app(H,L,R).
getSingleProduct([[_,_,_,D1],[_,_,_,D2]|T],L,R):-	
		D1=:=D2,
		deleteDuplicateNum(D1,T,Tnew),
		getSingleProduct(Tnew,L,R).
					
getSingleProduct([[A1,B1,C1,D1],[A2,B2,C2,D2]|T],L,R):-	
		D1=\=D2,
		app([[A1,B1,C1,D1]],L,Lnew),
		getSingleProduct([[A2,B2,C2,D2]|T],Lnew,R).									
getSingleProduct([],Ls,Ls).									
getSingleProduct([H|T],L,R):- 
		T = [],
		app([H],L,R).

deleteDuplicateNum(N,[[_,_,_,D]|T],R):-
		N=:=D,
		deleteDuplicateNum(N,T,R).
deleteDuplicateNum(N,[[A,B,C,D]|T],[[A,B,C,D]|T]):-
		N=\=D.
deleteDuplicateNum(_,[],[]).	

s2(Q,Max):-
		Maxnew is Max-1,
		getPrimeList(Maxnew,LPrime),			%small -> big
		Maxnew2 is Max/2,
		getPrimeList(Maxnew2,LPrimeS),			%the number which is <50
		setTheNum(2,Maxnew,LPrime,[],L1),		%all possible number except prime number big->smmal
		getMaxPrime(Maxnew2,MaxPrime),
		BigestSum is MaxPrime+2,
		toGetPL(BigestSum,LPrimeS,L1,PLList),				%not p* p
		toGetLL(BigestSum,L1,LLList),					%not p* not p
		app(PLList,LLList,TList),
		delete2AddPSum(TList,[],Result),
		deleteDivideBy3(Result,[],Result2),
		merge_sort(Result2,Q).


deleteDivideBy3([[A,B,S,P]|T],L,R):-
		S mod 3 =\=0,
		deleteDivideBy3(T,[[A,B,S,P]|L],R).
		
deleteDivideBy3([[A,B,S,P]|T],L,R):-
		S mod 3 =:=0,
		Test is S/3,		
		not(isPrime(Test,2)),
		deleteDivideBy3(T,[[A,B,S,P]|L],R).
deleteDivideBy3([[_,_,S,_]|T],L,R):-
		S mod 3 =:=0,
		Test is S/3,		
		isPrime(Test,2),
		deleteDivideBy3(T,L,R).
deleteDivideBy3([],L,L).
	
delete2AddPSum([[A,B,S,P]|T],L,R):-
		TestNumber is S-2,
		not(isPrime(TestNumber,2)),
		delete2AddPSum(T,[[A,B,S,P]|L],R).
delete2AddPSum([[_,_,S,_]|T],L,R):-
		TestNumber is S-2,
		isPrime(TestNumber,2),
		delete2AddPSum(T,L,R).
delete2AddPSum([],L,L).		

deleteSingleS([[A1,B1,S1,P1],[A2,B2,S2,P2]|T],L,R):-
		S1=:=S2,
		doMoreForS(S1,[[A1,B1,S1,P1],[A2,B2,S2,P2]|T],[],NewList,NewT),
		app(NewList,L,Lnew),
		deleteSingleS(NewT,Lnew,R).
deleteSingleS([[_,_,S1,_],[A2,B2,S2,P2]|T],L,R):-
		S1=\=S2,
		deleteSingleS([[A2,B2,S2,P2]|T],L,R).		
deleteSingleS([_|T],R,R):-
		T=[].		
deleteSingleS([],R,R).

doMoreForS(N,[[A,B,S,P]|T],Ls,R,NewT):-
		N=:=S,
		doMoreForS(N,T,[[A,B,S,P]|Ls],R,NewT).

doMoreForS(N,[[A,B,S,P]|T],R,R,[[A,B,S,P]|T]):-
		N=\=S.		
doMoreForS(_,[],R,R,[]).

deleteSingleP([[A1,B1,S1,P1],[A2,B2,S2,P2]|T],L,R):-
		P1=:=P2,
		doMoreForP(P1,[[A1,B1,S1,P1],[A2,B2,S2,P2]|T],[],NewList,NewT),
		app(NewList,L,Lnew),
		deleteSingleP(NewT,Lnew,R).
deleteSingleP([[_,_,_,P1],[A,B,S,P2]|T],L,R):-
		P1=\=P2,
		deleteSingleP([[A,B,S,P2]|T],L,R).		
deleteSingleP([_|T],R,R):-
		T=[].		
deleteSingleP([],R,R).


doMoreForP(N,[[A,B,S,P]|T],Ls,R,NewT):-
		N=:=P,
		doMoreForP(N,T,[[A,B,S,P]|Ls],R,NewT).

doMoreForP(N,[[A,B,S,P]|T],R,R,[[A,B,S,P]|T]):-
		N=\=P.		
doMoreForP(_,[],R,R,[]).

getMaxPrime(N,R):-
		not(isPrime(N,2)),
		Nnew is N+1,
		getMaxPrime(Nnew,R).
getMaxPrime(R,R):-
		isPrime(R,2).


toGetPL(Max,L1,L2,R):-
		getPLList(Max,L1,L2,[],R).

getPLList(_,[],_,Ls,Ls).
getPLList(Max,[H|T],L,Ls,R):-
		getEachPL(Max,H,L,[],PLnew),
		app(PLnew,Ls,Lsnew),
		getPLList(Max,T,L,Lsnew,R).	

getEachPL(_,_,[],L,L).
getEachPL(Max,E,[H|T],L,R):-
		E+H<Max,	
		Sum is E+H,
		Sum mod 2 =\=0,	
		E<H,				
		Product is E*H,
		app([[E,H,Sum,Product]],L,Lnew),
		getEachPL(Max,E,T,Lnew,R).	

getEachPL(Max,E,[H|T],L,R):-
		E+H<Max,	
		Sum is E+H,
		Sum mod 2 =\=0,	
		E>H,
		Product is E*H,
		app([[H,E,Sum,Product]],L,Lnew),
		getEachPL(Max,E,T,Lnew,R).	

getEachPL(Max,E,[H|T],L,R):-
		E+H<Max,	
		Sum is E+H,
		Sum mod 2 =:=0,
		getEachPL(Max,E,T,L,R).
					
getEachPL(Max,E,[H|T],L,R):-
		E+H>=Max,						%%可提升
		getEachPL(Max,E,T,L,R).
		
toGetLL(Max,L,R):- 
		rev(L,Lnew),
		getLLList(Max,Lnew,Lnew,[],R).
	

getLLList(_,[],_,L2,L2).
getLLList(Max,[H|T],L1,L2,R):- 
		getEachL(Max,H,L1,[],Lnew),
		app(Lnew,L2,L2new),
		getLLList(Max,T,L1,L2new,R).		

getEachL(_,_,[],L,L).
getEachL(Max,E,[H|T],L,R):-
		E<H,		
		E+H<Max,	
		Sum is E+H,	
		Sum mod 2 =\=0,			
		Product is E*H,		
		app([[E,H,Sum,Product]],L,Lnew),
		getEachL(Max,E,T,Lnew,R).										
				
getEachL(Max,E,[H|T],L,R):-
		E>=H,
		getEachL(Max,E,T,L,R).	
getEachL(Max,E,[H|T],L,R):-
		E<H,		
		E+H<Max,	
		Sum is E+H,	
		Sum mod 2 =:=0,
		getEachL(Max,E,T,L,R).									
getEachL(Max,E,[H|_],L,L):-
		E<H,
		E+H>=Max.
		
setTheNum(Max,Max,_,L,L).				
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

%test the number if is prime number		
isPrime(X,X).
isPrime(X,Y):-
		Y<X,
		0 =\= X mod Y,
		Ynew is Y+1,
		isPrime(X,Ynew).	

app([],L,L).
app([E|T],L,[E|M]) :- app(T,L,M).

merge_sort2([],[]).     % empty list is already sorted
merge_sort2([X],[X]).   % single element list is already sorted
merge_sort2(List,Sorted):-
    List=[_,_|_],divide(List,L1,L2),     % list with at least two elements is divided into two parts
	merge_sort2(L1,Sorted1),merge_sort2(L2,Sorted2),  % then each part is sorted
	merge2(Sorted1,Sorted2,Sorted).                  % and sorted parts are merged
merge2([],L,L).
merge2(L,[],L):-L\=[].
merge2([[A1,B1,S1,P1]|T1],[[A2,B2,S2,P2]|T2],[[A1,B1,S1,P1]|T]):-S1=<S2,merge2(T1,[[A2,B2,S2,P2]|T2],T).
merge2([[A1,B1,S1,P1]|T1],[[A2,B2,S2,P2]|T2],[[A2,B2,S2,P2]|T]):-S1>S2,merge2([[A1,B1,S1,P1]|T1],T2,T).

merge_sort([],[]).     % empty list is already sorted
merge_sort([X],[X]).   % single element list is already sorted
merge_sort(List,Sorted):-
    List=[_,_|_],divide(List,L1,L2),     % list with at least two elements is divided into two parts
	merge_sort(L1,Sorted1),merge_sort(L2,Sorted2),  % then each part is sorted
	merge(Sorted1,Sorted2,Sorted).                  % and sorted parts are merged
merge([],L,L).
merge(L,[],L):-L\=[].
merge([[A1,B1,S1,P1]|T1],[[A2,B2,S2,P2]|T2],[[A1,B1,S1,P1]|T]):-P1=<P2,merge(T1,[[A2,B2,S2,P2]|T2],T).
merge([[A1,B1,S1,P1]|T1],[[A2,B2,S2,P2]|T2],[[A2,B2,S2,P2]|T]):-P1>P2,merge([[A1,B1,S1,P1]|T1],T2,T).


divide(L,L1,L2):-halve(L,L1,L2).
halve(L,A,B):-hv2(L,L,A,B).
   
hv2([],R,[],R).   % for lists of even length
hv2([_],R,[],R).  % for lists of odd length
hv2([_,_|T],[X|L],[X|L1],R):-hv2(T,L,L1,R).


theMember(E,[E|_]):-!.
theMember(E,[_|R]) :- theMember(E,R).