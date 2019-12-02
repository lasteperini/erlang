-module(list1).

-export([min/1, mymin/2, max/1, mymax/2, min_max/1]).

min([A | Rest]) ->
	mymin([A | Rest], A).

mymin([], A) ->
	A;
mymin([X],_) ->
	X;
mymin([A|Rest],_) ->
	mymin([X || X <- Rest , X < A],A).

max([A | Rest]) ->
	mymax([A | Rest], A).

mymax([], A) ->
	A;
mymax([X],_) ->
	X;
mymax([A|Rest],_) ->
	mymax([X || X <- Rest , X > A],A).

min_max(List) ->
	{min(List), max(List)}.


