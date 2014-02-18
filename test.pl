test(X,_,X).
test(X,[X|[H|T]],R):-
	test(H,[H|T],R).	
	