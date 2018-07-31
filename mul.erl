%File to test out multi threaded functionality of Erlang

-module(mul).
-export([start_spawn/0, say/2]).
-export([start_chat/0, bot1/0, bot2/2]).

say(What, 0) ->
    done;
say(What,Times) ->
    io:fwrite("~p~n",[What]),
    say(What, Times-1).

start_spawn() ->
    spawn(mul, say, [hello, 3]),
    spawn(mul, say, [bye, 3]). %returns process identifier

%Multi threaded Chat
bot2(0, Bot1_PID) ->
    Bot1_PID ! finished,
    io:fwrite("Bot2 Done~n");
bot2(N, Bot1_PID) ->
    Bot1_PID ! {bot2, self()},
    receive 
        bot1 ->
            io:format("bot1 said some shit to bot2~n")
    end,
    bot2(N-1, Bot1_PID).

bot1() ->  %receive some shit and then talk
    receive 
        finished ->
            io:fwrite("Bot1 Finished~n");
        {bot2, Bot2_PID} ->
            io:format("bot1 received some shit from bot2~n"),
            Bot2_PID ! bot1, %exclaimation is send to ! message
            bot1()
        end.

start_chat() ->
    Bot1_PID = spawn(mul, bot1, []),
    spawn(mul, bot2, [3, Bot1_PID]).


%the process need to know about each other PIDs so that they can communicate.
%This can be done by register BIF (Build in Function)
% register(RegisterID, spawn(moduleName, FunctionName, []))
% and it will be used like: RegesterID ! Message