-module(gh_341).

-export([frazzle/0]).

frazzle() ->
    io:write("Hello World!~n").

-ifdef(TEST).

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

riak_connect_test() ->
    {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
    Result = riakc_pb_socket:ping(Pid),
    ?debugFmt("PING: ~p~n", [Result]),
    Object    = riakc_obj:new(<<"test">>,
                              <<"eunit-1">>,
                              <<"test">>),
    ok        = riakc_pb_socket:put(Pid, Object),
    ok.

-endif.
