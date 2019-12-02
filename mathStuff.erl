-module(mathStuff).

-export([perimeter/1]).


perimeter({square,Side}) ->
	io:format("square perimeter is ~p~n",[Side*Side]);
	
perimeter({circle,Radius}) ->
	io:format("cicle perimeter is ~p~n",[math:pi()*Radius]);

perimeter({triangle,A,B,C}) ->
	io:format("triangle perimeter is ~p~n",[A+B+C]);

perimeter({_,_}) ->
			not_defined.
	
