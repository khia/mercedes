-module(mercedes_app).

-behaviour(application).

-export([start/2, stop/1]).

-define(ACCEPTORS, 10).

start(_StartType, _StartArgs) ->
  Routes    = routes(),
  Dispatch  = cowboy_router:compile(Routes),
  Port      = port(),
  TransOpts = [{port, Port}],
  ProtoOpts = [{env, [{dispatch, Dispatch}]}],
  {ok, _}   = cowboy:start_http(http, ?ACCEPTORS, TransOpts, ProtoOpts),

  mercedes_sup:start_link().

stop(_State) ->
    ok.

routes() ->
  [
    {'_', [
      {"/", mercedes_handler, []}
    ]}
  ].

port() ->
  {ok, Port} = application:get_env(http_port),
  Port.
