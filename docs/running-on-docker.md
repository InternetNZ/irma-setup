# Running on docker

IRMA stack can be run through docker.

You can call the utility `./run-docker.sh` that will take care for some more things than just `docker-compose up`. So 
you should give it a try and read their content.

Requirements:

- [Repositories](#Repositories)
- [Certs](#mkcert-for-local-development)
- [Configs](#Configs-and-scheme-sign)

## Repositories

You need all IRMA repositories at the same level.

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

## mkcert for local development

We run a nginx proxy for https and local development. If you don't have valid certificates, you 
won't be able to use the application. Fortunately, creating valid certificates is easy!

* Install [mkcert](https://github.com/FiloSottile/mkcert)
* `mkcert -install`
* `mkdir -p ./certs`
* `mkcert -cert-file ./certs/local.internetnz.nz.crt -key-file ./certs/local.internetnz.nz.key local.internetnz.nz "*.local.internetnz.nz" localhost 127.0.0.1 ::1`

Then add all used hosts to your hosts file:

```
127.0.0.1 irma-keyshare.local.internetnz.nz
127.0.0.1 irma.local.internetnz.nz
127.0.0.1 irmago.local.internetnz.nz
127.0.0.1 irma-scheme.local.internetnz.nz
127.0.0.1 irma-demoui.local.internetnz.nz
```

## Configs and scheme sign

We still need to do some tiny manual configs. Please check:

1. Some config files still need to have the actual IP of hosting machine. We need to change:

|File   | Configuration  |
|----|-------------|
|irma-setup/.env                    | IRMASERVER_URL=<yourIP>:8088|
|inz-demo/inz-demo/description.xml  | <KeyshareServer>http://<yourIP>:8080/irma_keyshare_server/api/v1</KeyshareServer> |
|irma_keyshare_server/src/main/resources/config.json    | "url": "http://<yourIP>:8080/irma_keyshare_server/api/v1" |

2. After changing the IP, you need to sign scheme again (scheme signing depends on content). To do that:

```bash
cd /path/irma-setup
make irmago-bash
# when into container
irma scheme sign
```

After that you can run your docker setup.

## Utilities

### mitmproxy

If you want to keep track of the IRMA communication when running on local, you can use mproxy to proxy all requests 
in a way that can help you when sniffing the communications.

```bash
# can proxy keyshare server
mitmproxy -p 18088 --mode reverse:http://localhost:8088/
mitmproxy -p 18080 --mode reverse:http://localhost:8080/
```
