help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean-start:			## Clean, setup then start.
clean-start: stop-all up-all

stop-all:
	docker stop $$(docker ps -q)

up:
	docker-compose -f docker-compose.yml up --remove-orphans -d

up-build:
	docker-compose -f docker-compose.yml up --build --remove-orphans -d
         
up-nd:
	docker-compose -f docker-compose.yml up --remove-orphans

irmago-bash:
	docker-compose -f docker-compose.yml run -u $$UID:$$GID --rm irmago bash

irmago-bash-root:
	docker-compose -f docker-compose.yml run --rm irmago bash

irmago-pbdf-demo-scheme:	## Get into irma-cli container with pbdf demo scheme (located at ../pbdf-irma-demo-schememanager)
	docker-compose -f docker-compose.yml \
		run -u $$UID:$$GID -v $$PWD/../pbdf-irma-demo-schememanager:/irma/schemes/irma-demo:cached --rm irmago bash

irmago-sign-scheme:		## Use irma-cli container to sign and verify our inz scheme
	docker-compose -f docker-compose.yml run -u $$UID:$$GID --rm irmago bash -c 'irma scheme sign && irma scheme verify'

rmi-all:
	docker-compose -f docker-compose.yml down --remove-orphans --rmi=local
