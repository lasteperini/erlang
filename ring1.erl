% Write a program that will create N processes connected in a ring. 
% Once started, these processes will send M number of messages around the ring and then terminate 
% gracefully when they receive a quit message. You can start the ring with the call ring:start(M, N, Message).

% There are two basic strategies to tackling this exercise. 
% The first one is to have a central process that sets up the ring and initiates sending the message. 
% The second strategy consists of the new process spawning the next process in the ring. 
% With this strategy, you have to find a method to connect the first process to the second process.

% Try to solve the exercise in both manners. 
% Note, when writing your program, make sure your code has many io:format statements in every loop iteration; 
% this will give you a complete overview of what is happening (or not happening) and should help you solve the exercise.

-module(ring1).
-export([start/3, loop/4, printMsg/1]).

start(M, N , Message) ->
	spawn(?MODULE, loop, [M,N, Message,N]).

loop(M,0,Message,N) ->
	io:format("~p 0 ~p process: ~p~n", [M, Message, self()]),
	printMsg(M);
	%spawn(?MODULE, loop, [M,N, Message,N]);

		
loop(M,N,Message,Ncost) ->
	io:format("~p ~p ~p process: ~p~n", [M, N, Message, self()]), 
	printMsg(M),
	spawn(?MODULE,loop, [M,N-1,Message,Ncost]).

printMsg(0) ->
	io:format("");
printMsg(M) ->
	io:format("~p: My Message ~n", [M]),
	printMsg(M-1).
