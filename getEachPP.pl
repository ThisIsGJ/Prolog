getEachPP(Max,E,[],L,L).					
getEachPP(Max,E,[H|T],L,R):-
		Product is E*H,
		Product=<Max,		
		app([Product],L,Lnew),
		getEachPP(Max,E,T,Lnew,R).		
getEachPP(Max,E,[H|T],L,L):-
		E*H>Max.
		
app([],L,L).
app([E|T],L,[E|M]) :- app(T,L,M).		