-module(ping_pomng).
-export([send/2, pong/0, ping/0]).

send(Message,M) ->
	register(ping_proc, spawn(?MODULE, ping , [])),
	register(pong_proc, spawn(?MODULE, pong , [])),
	ping_proc ! {self(), Message, M},
	receive
		ready ->
			ok
	after 5000 ->
		{error, timeout}
	end.
		

ping() ->
	receive
		{From,_,0} ->
			From ! ready;
		{From, Message, M} ->
			io:format("Ping ~p with counter ~p~n",[Message,M]),
			pong_proc ! {From, Message,M-1},
			ping()
	end.

pong() ->
	receive
		{From,_,0} ->
			From ! ready;
		{From, Message, M} ->
			io:format("Pong ~p with counter ~p~n",[Message,M]),
			ping_proc ! {From,Message,M-1},
			pong()
	end.
