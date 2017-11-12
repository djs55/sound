.PHONY: run
run: _build/default/main.exe
	./_build/default/main.exe

_build/default/main.exe: main.ml common.ml sine.ml
	jbuilder build main.exe

.PHONY: clean
clean:
	jbuilder clean
