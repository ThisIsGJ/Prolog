getn([H|T],R,N):-
	Rnew is R+1,
	getn(T,Rnew,N).
getn([],R,R).	