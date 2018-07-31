-module(tut).
-export([fac/1, mult/2, disp/1, dispTill/1, fibo/1, convert/2, convert_len/1, convert_length/1, list_len/1, 
demo_io/0, list_max/1, list_reverse/1, disp_something/1]).


fac(1) ->
	1;

fac(N) ->
	if	N > 1 ->
		1;
	true ->
		N * fac(N - 1)
end.

mult(X, Y) ->
	X * Y.

disp(X) ->
	io:format("~p",[X*X]).

dispTill(X) ->
	io:format("~p ", [X]),
	if
		X > 1 ->
		dispTill(X-1);
	true ->
		X - 1
	end.

fibo(N) ->
	if N == 1 ->
		1;
	true ->
		if N == 2 ->
			2;
		true ->
			fibo(N-1) + fibo (N-2)
		end
	end.


%Atoms - names, nothing else, starts with small letter

convert(N, inch) ->
	N/2.54;
convert(N, cm) ->
	N*2.54.

%tuples - grouping, considered as 1 argument
%tuples can be comples {a,{b,c}} - i.e. composition is allowed
convert_len({cm, N}) ->
	{inch, N/2.54};
convert_len({inch, N}) ->
	{cm, N*2.54}.

%better version - switch case
convert_length(Length) ->
	case Length of 
		{cm, X} -> {cm, X/2.54};
		{in, X} -> {in, X*2.54}
	end.

%Lists - collection of objects
%[1,2,3,4,5] | [{a,b}, {c,d}]
%A good way to look at list is [E1, E2 | Rest] = {1,2,3,4,5} 
%E1 = 1, E2 = 2, Rest = 3,4,5
%If in this case Rest didnt have any element, it would show as Empty List []
%and No looping, only recursion
%variable Names are capital

list_len([]) ->
	0;
list_len([First | Rest]) ->
	1 + list_len(Rest).

%man pages can be accessed via erl -man *topic name* eg erl -man io

%Standard IO
%io:format("your text ~n",[]).

demo_io() ->
	io:format("New Line at end~n",[]),
	io:format("Print Some stuff:: ~w ~w ~n", [jatin, chaudhary]).

%public : function mentioned in export
%private, rest of the functions

%code for finding max 
list_max_f([Head | Rest], Max) ->
	if
	Head > Max ->
		list_max_f(Rest,Head);
	true ->
		list_max_f(Rest,Max)
	end;
list_max_f([], Max) ->
	Max.

list_max([Head | Rest]) ->
	list_max_f([Head | Rest], Head).

%Reverse a list
list_reverse_f([Head|Rest],RevList) ->
	list_reverse_f(Rest,[Head | RevList]);
list_reverse_f([],RevList) ->
	RevList.

list_reverse(List) ->
	list_reverse_f(List,[]).


%If Else
disp_something(N) ->
	if
		N == 3 ; N == 6 ->   %N is 3 or 6
			io:fwrite("The value is either 3 or 6 ~n");
		N rem 2 == 0, N rem 3 == 0 ->  %divisible by 2 and 3
			io:fwrite("The value is divisible by 2 and 3~n");
		N >= 10 ->
			io:fwrite("The value is greater than 10~n");
		true ->
			io:fwrite("The value is less than 10 ~n")
	end.

