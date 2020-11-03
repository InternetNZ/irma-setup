help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean-start:       ## Clean, setup then start.
clean-start: stop-all up-all

stop-all:
	docker stop $$(docker ps -q)

up-all:
	docker-compose -f docker-compose.yml up --remove-orphans -d

up-all-nd:
	docker-compose -f docker-compose.yml up --remove-orphans

irmago-bash:
	docker-compose -f docker-compose.yml run -u $$UID:$$GID --rm irmago bash

irmago-sign-scheme:
	docker-compose -f docker-compose.yml run -u $$UID:$$GID --rm irmago bash -c 'irma scheme sign && irma scheme verify'

irmago-pbdf-scheme:
	docker-compose -f docker-compose.yml \
		run -u $$UID:$$GID -v $$PWD/../inz-demo/pbdf:/irma/schemes/pbdf:cached --rm irmago bash

irmago-bash-root:
	docker-compose -f docker-compose.yml run --rm irmago bash

rmi-all:
	docker-compose -f docker-compose.yml down --remove-orphans --rmi=local
