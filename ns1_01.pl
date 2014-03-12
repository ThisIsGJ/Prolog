%right s1
test(Max,L):-
	s1(Q,Max),
	getn(Q,0,L).
	
getn([_|T],R,N):-
	Rnew is R+1,
	getn(T,Rnew,N).
getn([],R,R).

s1(Q,Max):-
		Maxnew is Max-1,
		getPrimeList(Maxnew,LPrime),			%small -> big
		Maxnew2 is Max/2,
		getPrimeList(Maxnew2,LPrimeS),			%the number which is <50
		setTheNum(2,Maxnew,LPrime,[],L1),		%all possible number except prime number big->smmal
		toGetPL(Max,LPrimeS,L1,PLList),				%not p* p
		toGetLL(Max,L1,LLList),					%not p* not p
		app(PLList,LLList,Result),
		remove([_,_,_,16],Result,Result2),
		remove([_,_,_,81],Result2,Result3),
		quicksort2(Result3,Result4),
		getFinalAns(Result4,[],Q).


getFinalAns([[A1,B1,S1,P1],[A2,B2,S2,P2]|T],L,R):-
		P1=:=P2,
		doMore(P1,[[A1,B1,S1,P1],[A2,B2,S2,P2]|T],[],NewList,NewT),
		app(NewList,L,Lnew),
		getFinalAns(NewT,Lnew,R).
getFinalAns([[_,_,_,P1],[A,B,S,P2]|T],L,R):-
		P1=\=P2,
		getFinalAns([[A,B,S,P2]|T],L,R).		
getFinalAns([_|T],R,R):-
		T=[].		
getFinalAns([],R,R).


doMore(N,[[A,B,S,P]|T],Ls,R,NewT):-
		N=:=P,
		doMore(N,T,[[A,B,S,P]|Ls],R,NewT).

doMore(N,[[A,B,S,P]|T],R,R,[[A,B,S,P]|T]):-
		N=\=P.		
doMore(_,[],R,R,[]).


toGetPL(Max,L1,L2,R):-
		getPLList(Max,L1,L2,[],R).

getPLList(_,[],_,Ls,Ls).
getPLList(Max,[H|T],L,Ls,R):-
		getEachPL(Max,H,L,[],PLnew),
		app(PLnew,Ls,Lsnew),
		getPLList(Max,T,L,Lsnew,R).	

getEachPL(_,_,[],L,L).
getEachPL(Max,E,[H|T],L,R):-
		E+H=<Max,
		E*E=\=H,		
		E<H,
		Sum is E+H,
		Product is E*H,
		app([[E,H,Sum,Product]],L,Lnew),
		getEachPL(Max,E,T,Lnew,R).	

getEachPL(Max,E,[H|T],L,R):-
		E+H=<Max,
		E*E=\=H,		
		E>H,
		Sum is E+H,
		Product is E*H,
		app([[H,E,Sum,Product]],L,Lnew),
		getEachPL(Max,E,T,Lnew,R).			
										
getEachPL(Max,E,[H|T],L,R):-
		E+H=<Max,
		E*E=:=H, 	     						%cannot p*p*p such as 2*2*2=2*4=8					 					
		getEachPL(Max,E,T,L,R).		
getEachPL(Max,E,[H|T],L,R):-
		E+H>Max,						%%可提升
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
		E+H=<Max,		
		not(testP2(E,H)),					%cannot have 2^11
		Sum is E+H,
		Product is E*H,		
		app([[E,H,Sum,Product]],L,Lnew),
		getEachL(Max,E,T,Lnew,R).										
				
getEachL(Max,E,[H|T],L,R):-
		E>=H,
		E+H=<Max,
		getEachL(Max,E,T,L,R).					
getEachL(Max,E,[H|T],L,R):-
		E<H,		
		testP2(E,H),						%cannot have 2^11     					
		getEachL(Max,E,T,L,R).

						
getEachL(Max,E,[H|_],L,L):-
		E+H>Max.

testP2(E,H):-
		E*H=:=2048,
		E+H=:=96.										




%get the smalles factor of H
getSamllestFactorOfH(E,T,R):-
		T<E,
		E mod T=\=0,
		Tnew is T+1,
		getSamllestFactorOfH(E,Tnew,R).		
getSamllestFactorOfH(E,T,T):-
		T<E,
		E mod T=:= 0.	
		
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

quicksort([],[]).
quicksort(List,Sorted)     :- var(List), 
                             !, 
                             perm(Sorted,List),
                             quicksort(List,Sorted).
quicksort([X|Tail],Sorted) :- tosplit(X,Tail,Small,Big),
                             quicksort(Small,SortedSmall),
                             quicksort(Big,SortedBig),
                             app(SortedSmall,[X|SortedBig],Sorted).

tosplit(_,[],[],[]).
tosplit([A,B,X,D],[[E,F,Y,G]|Tail],[[E,F,Y,G]|Small],Big)  :- X > Y,
                                   !,
                                   tosplit([A,B,X,D],Tail,Small,Big).
tosplit( [A,B,X,D],[[E,F,Y,G]|Tail],Small,[[E,F,Y,G]|Big]) :- tosplit([A,B,X,D],Tail,Small,Big).

app([],L,L).
app([E|T],L,[E|M]) :- app(T,L,M).

perm([],[]).
perm(X,[E|Y]) :- remove(E,X,Z),
                perm(Z,Y).

remove(X,[X|R],R).
remove(X,[E|R],[E|T]) :- remove(X,R,T).	

member(E,[E|_]):-!.
member(E,[_|R]) :- member(E,R).