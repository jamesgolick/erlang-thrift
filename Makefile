REBAR = ./rebar
THRIFT = thrift

.PHONY: all compile compile-thrift test clean deps

all: deps compile

deps:
	@./rebar get-deps

compile:
	@$(REBAR) compile

compile-thrift:
	@for file in test/*.thrift ; do \
		$(THRIFT) --out test --gen erl $$file ; \
	done

test: compile-thrift
	@$(REBAR) eunit skip_deps=true

clean:
	@rm -f test/*_{thrift,types,constants}.{e,h}rl
	@$(REBAR) clean
