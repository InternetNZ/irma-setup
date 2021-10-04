# IRMA Go Server

a.k.a. [irmago](https://github.com/privacybydesign/irmago)

Irmago is an IRMA implementation in Golang. It contains the data model, business logic to handle requests, generate, 
and store credentials. Also, it provides the command-line tool `irma`, which amongst others, can start an IRMA server 
instance. When running an IRMA server, two endpoints are exposed: `/irma`, that is used by the IRMA app during IRMA 
sessions. And `/sessions`, that is used by requestors, enabling them to initiate a session, monitor them and retrieve 
session results.

## Requestor Authentication methods

The server supports several authentication methods, one of which must be specified in the auth_method field for each requestor.

- `token`: the requestor must include the key as an API token in a HTTP header.
- `hmac`: the requestor symmetrically signs the session request in a JWT, with HMAC-SHA256 (HS256) using key. The key provided should be the Base64 encoding of the actual secret.
- `publickey`: the requestor asymmetrically signs the session request in a JWT with RSA (RS256), in this case key should be the PEM public key of the requestor.

### token

To setup a requestor in irmago server to accept a token, the config should be like:

```json
{
    "requestors": {
        "myapp": {
            "auth_method": "token",
            "key": "eGE2PSomOT84amVVdTU"
        }
    }
}
```

### publickey

To setup irmago server to accept JWT sign messages instead of token, the requester has to be set
to `publickey`:

```json
{
    "requestors": {
        "myapp": {
            "auth_method": "publickey",
            "key_file": "/irma/jwtkeys/requestor1.pem"
        }
    }
}
```

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

