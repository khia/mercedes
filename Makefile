ERLPATH=-pa ebin deps/*/ebin
.PHONY: clean

all: ebin/*.app

deps:
	rebar get-deps && rebar make-deps

ebin/*.app: deps src/*
	rebar compile

start: ebin/*.app
	erl $(ERLPATH) -boot start_sasl -s mercedes -s reloader

clean:
	@rm -f ebin/*
