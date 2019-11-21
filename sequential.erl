%Define the following functions in Erlang:
% is_palindrome: string → bool that checks if the string given as input is palindrome, 
% a string is palindrome when the represented sentence can be read the same way in either 
% directions in spite of spaces, punctual and letter cases, e.g., detartrated, 
% "Do geese see God?", "Rise to vote, sir.", ...;
% is_an_anagram : string → string list → boolean that given a dictionary of strings, 
% checks if the input string is an anagram of one or more of the strings in the dictionary;
% factors: int → int list that given a number calculates all its prime factors;
% is_proper: int → boolean that given a number calculates if it is a perfect number or not, 
% where a perfect number is a positive integer equal to the sum of its proper positive 
% divisors (excluding itself), e.g., 6 is a perfect number since 1, 2 and 3 are the proper 
% divisors of 6 and 6 is equal to 1+2+3;

% NB: copied from another student 


-module(sequential).
-export([is_palindrome/1, is_an_anagram/1, factors/1, is_proper/1]).

filtro(S)->lists:filter(fun (X)->(X>=97) and (X=<122) end, S).

is_palindrome(Stringa)->
	Filtrata=filtro(string:lowercase(Stringa)),
	Filtrata==string:reverse(Filtrata).

is_an_anagram(X,S) ->
	lists:sort(X)==lists:sort(S).

factors(X)->factors(X, 2, []).
factors(1, _, _)-> [1];
factors(X, I, Acc) when I==X->lists:reverse([I|Acc]);
factors(X, I, Acc) when (trunc(X) rem I)=:=0 -> factors((X/I), I, [I|Acc]);
factors(X, I, Acc) -> factors(X, (I+1), Acc).

divisore(X, I) -> (X rem I)==0.
	
divisors(X, I, Acc) when ((X rem I)==0) and (I<X) -> divisors(X, (I+1), [I|Acc]);
divisors(X, I, Acc) when X=<I -> lists:reverse(Acc);
divisors(X, I, Acc) -> divisors(X,(I+1),Acc).

is_proper(X)-> X==(lists:foldr((fun(A,B)->A+B end), 0, divisors(X, 2, [1]))).
	
