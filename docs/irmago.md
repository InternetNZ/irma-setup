# IRMA Go Server

a.k.a. [irmago](https://github.com/privacybydesign/irmago)

Irmago is an IRMA implementation in Golang. It contains the data model, business logic to handle requests, generate, 
and store credentials. Also, it provides the command-line tool `irma`, which amongst others, can start an IRMA server 
instance. When running an IRMA server, two endpoints are exposed: `/irma`, that is used by the IRMA app during IRMA 
sessions. And `/sessions`, that is used by requestors, enabling them to initiate a session, monitor them and retrieve 
session results.

## Keys

All keys should be in sync to enable requestors authentication through IRMA sessions.

*keyshare*

When configuration session authentication from keyshare server, a public key generated from the private key used 
for keyshare must be used for irma server. 

To generate, use private key under `/path/keyshare/src/main/resources/sk.der` and save public key at 
`build/irmago/jwtkeys/pk.pem`.

```bash
cd build/irmago/jwtkeys/
openssl rsa -inform DER -pubout -outform PEM -in /path/keyshare/src/main/resources/sk.der -out pk.pem
``` 

