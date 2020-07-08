help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

setup:       ## Download code, run set up scripts and install dependencies.
	./setup.sh

start:       ## Start docker containers.
	./start.sh

clean:       ## Remove all downloaded and compiled files
	./clean.sh

clean-start:       ## Clean, setup then start.
clean-start: clean setup start

stop-all:
	docker stop $(docker ps -q)

scheme:
	docker-compose -f docker-compose-scheme.yml up -d

scheme-rmi:
	docker-compose -f docker-compose-scheme.yml down --rmi=local

copy-scheme:
	sh copy-scheme.sh
