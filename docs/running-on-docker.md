# Running on docker

IRMA stack can be run through docker.

You can call the utility `./run-docker.sh` that will take care for some more things than just `docker-compose up`. So 
you should give it a try and read their content.

## Requirements

**1. You need all IRMA repositories at the same level**

This setup repo will use contents from other repos, so they must exist and in the right place.

```bash
➜   tree -L 1
.
├── inz-demo
├── irma-demo-ui
├── irmago
├── irma_keyshare_server
├── irma_mobile
├── irma_mobile-docker
├── irma-setup
├── irma-tf
```

Observe that inz-demo-scheme was renamed to inz-demo. You need to rename on your end as well for now.

**2. mkcert for local development**

We run an nginx proxy for https and local development. If you don't have valid certificates, you 
won't be able to use the application. Fortunately, creating valid certificates is easy!

* Install [mkcert](https://github.com/FiloSottile/mkcert)
* `mkcert -install`
* `mkdir -p ./certs`
* `mkcert -cert-file ./certs/local.internetnz.nz.crt -key-file ./certs/local.internetnz.nz.key local.internetnz.nz "*.local.internetnz.nz" localhost 127.0.0.1 ::1`


## Utilities

### mitmproxy

If you want to keep track of the IRMA communication when running on local, you can use mproxy to proxy all requests 
in a way that can help you when sniffing the communications.

```bash
# can proxy keyshare server
mitmproxy -p 18088 --mode reverse:http://localhost:8088/
mitmproxy -p 18080 --mode reverse:http://localhost:8080/
```
