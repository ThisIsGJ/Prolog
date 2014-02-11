setList(1,L,L).

setList(N,L,A):-
		N>1,
		app([N],L,LNEW),
		N2 is N - 1,
		setList(N2,LNEW,A).

app([],L,L).
app([E|T],L,[E|M]) :- app(T,L,M).
