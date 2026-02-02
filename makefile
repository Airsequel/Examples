.PHONY: help
help: makefile
	@tail -n +4 makefile | grep ".PHONY"


.PHONY: format
format:
	elmfmt -i elm-simple-todo-app/src todomvc-elm/src
