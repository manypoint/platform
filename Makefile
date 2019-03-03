GOBIN=$(shell pwd)/bin
GOFILES=$(shell find . -type f -name '*.go')
GONAME="manypoint"

build:
	@echo "Building $(GOFILES) to ./bin"
	GOBIN=$(GOBIN) go build -o bin/$(GONAME) 

get:
	GOBIN=$(GOBIN) go get .

install:
	GOBIN=$(GOBIN) go install $(GOFILES)

watch:
	@$(MAKE) restart &
	@fswatch -o . -e 'bin/.*' | xargs -n1 -I{}  make restart

restart: clear stop clean build start

start:
	@echo "Starting bin/$(GONAME)"
	@./bin/$(GONAME) & echo $$! > $(PID)

stop:
	@echo "Stopping bin/$(GONAME) if it's running"
	@-kill `[[ -f $(PID) ]] && cat $(PID)` 2>/dev/null || true

clear:
	@clear

clean:
	@echo "Cleaning"
	GOBIN=$(GOBIN) go clean

.PHONY: build get install run watch start stop restart clean
