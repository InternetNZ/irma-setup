help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean-start:       ## Clean, setup then start.
clean-start: stop-all

stop-all:
	docker stop $$(docker ps -q)

scheme-up:
	docker-compose -f docker-compose-scheme.yml up -d

scheme-rmi:
	docker-compose -f docker-compose-scheme.yml down --rmi=local

copy-scheme:
	sh copy-scheme.sh

scheme-bash:
	docker-compose -f docker-compose-scheme.yml run scheme bash

irmago-bash:
	docker-compose -f docker-compose.yml run -u $$UID:$$GID --rm irmago bash

irmago-bash-root:
	docker-compose -f docker-compose.yml -f docker-compose-scheme.yml run --rm irmago bash

rmi-all:
	docker-compose \
		-f docker-compose.yml -f docker-compose-demoui.yml -f docker-compose-keyshare.yml \
		 down --remove-orphans --rmi=local
