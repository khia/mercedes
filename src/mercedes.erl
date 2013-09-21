-module(mercedes).

-export([start/0]).

start() ->
  start(mercedes).

start(App) ->
  case application:start(App) of
    {error, {not_started, Dep}} ->
      start(Dep),
      start(App);
    Other ->
      Other
  end.