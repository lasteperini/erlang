% The hamiltonian function takes two parameters, the first
% is the message and the second is the path we want to check as Hamiltonian; the path is a list of labels
% after the Gray's code labels. We get the proof that the given path is Hamiltonian by piggybacking the
% message with the labels of the processes it passes through. At the end the piggybacked message is
% returned to the process invoking the function that prints it showing the result. If it is Hamiltonian no
% label should appear twice. Note that not all the possible permutations on the Gray's code give
% a feasible path (this is due to the limited number of connections each nodes has).

% 1> hypercube:create().
% The process labeled "0000" just started
% The process labeled "0001" just started
% The process labeled "0011" just started
% The process labeled "0010" just started
% The Process labeled "0110" just started
% The Process labeled "0111" just started
% The Process labeled "0101" just started
% The Process labeled "0100" just started
% The Process labeled "1100" just started
% The Process labeled "1101" just started
% The Process labeled "1111" just started
% The Process labeled "1110" just started
% The Process labeled "1010" just started
% The Process labeled "1011" just started
% The Process labeled "1001" just started
% The Process labeled "1000" just started
% true

% hypercube:hamilton("Hello", hypercube:gray(4)).
% {msg,
% 	{src,"1000",msg,
% 		{src,"1001",msg,
% 			{src,"1011",msg,
% 				{src,"1010",msg,
% 					{src,"1110",msg,
% 						{src,"1111",msg,
% 							{src,"1101",msg,
% 								{src,"1100",msg,
% 									{src,"0100",msg,
% 										{src,"0101",msg,
% 											{src,"0111",msg,
% 												{src,"0110",msg,
% 													{src,"0010",msg,
% 														{src,"0011",msg,
% 															{src,"0001",msg,{src,"0000",msg,"Hello"}}}}}}}}}}}}}}}}}

-module(hypercube).
-export([create/0, create_node/2, stop/0, hamiltonian/1]).
	

create() ->
	register(hyper, spawn_link(?MODULE, create_node, [self(), 0])),
	receive 
		ready -> true
	after 5000 ->
		timeout
	end.


create_node(Start, 16) ->
	Start ! ready,
	loop_last(Start);

create_node(Start, Node) ->
	Next = spawn_link(?MODULE, create_node, [Start, Node+1]),
	io:format("The process labeled ~p just started~n", [integer_to_list(Node, 2)]),
	loop(Next, Node).

loop(NextProcess, N) ->
	receive
		stop -> 
			NextProcess ! stop,
			ok;
		{src,Val, msg, Msg} -> 
			NextProcess ! {src, integer_to_list(N, 2), msg, {src,Val, msg, Msg}},
			loop(NextProcess, N)
	end.
		
loop_last(NextProcess) ->
		receive
			stop -> exit(normal),unregister(hyper);
			{src,Val, msg, Msg} -> 
				io:format("last msg:~p~n", [Msg]),
				loop_last(NextProcess)
		end.

stop() -> hyper ! stop.

hamiltonian(Msg) ->
	hyper ! {src,"0000", msg, Msg}.
