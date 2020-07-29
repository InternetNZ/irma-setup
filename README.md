# IRMA SETUP

This reposity will have docs to ease the process of IRMA setup.

IRMA architecture consists of related components:

- [IRMA Mobile](#irma-mobile)
- [IRMA Keyshare Server](#irma-keyshare-server)
- [IRMA Go Server](#irma-go-server)
- [IRMA Scheme Manager](#irma-scheme-manager)
- [IRMA UI](#irma-ui)

Check [running on docker](docs/running-on-docker.md) to prepare your environment.

TL;DR: `./run-docker.sh`

## IRMA Mobile

a.k.a.: [irma_mobile](https://github.com/InternetNZ/irma_mobile)

Mobile client application for IRMA. Users need to install the IRMA app on her mobile device, which users can download 
from the official Android and iOS app stores. irma_mobile depends on irmago as the business logic is handled entirely 
within irmago. By implementing the data model and supporting code within irmago, the IRMA project only needs to maintain 
those in one central place.

irma_mobile is a react native application and more information can be found at repositories README file.

## IRMA Keyshare Server

a.k.a. [irma_keyhsare_server](https://github.com/InternetNZ/irma_keyshare_server)

The keyshare server has multiple responsibilities. First, it can validate the PIN entered by the user. Only then, the 
KSS allows the session to continue. Second, it can block a user for a certain amount of time if the user enters the 
PIN wrong too many times. Third, for users, it is also possible to block their account via the KSS website. 

[More details](docs/keyshare.md)

## IRMA Go Server

a.k.a. [irmago](https://github.com/privacybydesign/irmago)

Irmago is an IRMA implementation in Golang. It contains the data model, business logic to handle requests, generate, 
and store credentials. Also, it provides the command-line tool `irma`, which amongst others, can start an IRMA server 
instance. When running an IRMA server, two endpoints are exposed: `/irma`, that is used by the IRMA app during IRMA 
sessions. And `/sessions`, that is used by requestors, enabling them to initiate a session, monitor them and retrieve 
session results.

[More details](docs/irmago.md)

## IRMA Scheme Manager

a.k.a. [irma-demo-scheme](https://github.com/InternetNZ/inz-demo-scheme)

The responsibility of the scheme manager is to maintain the information of one ore more IRMA schemes and distribute it 
to relevant parties. Anyone can start a new scheme, and consequently, become the scheme manager for that scheme.

The PbDF maintains its scheme called ["pbdf-schememanager"](https://github.com/privacybydesign/pbdf-schememanager), which the IRMA app uses by default.

## IRMA UI

a.k.a. [irmajs](https://github.com/InternetNZ/irma-demo-ui)

The irmajs component is essentially a JavaScript client that consumes the RESTful JSON API from the irmago component. 
When interacting with either the issuer or verifier, the user browses to a website from that party. Then, the irmajs 
component requests the session from the IRMA server. Subsequently, it generates the QR-code or deep-link to communicate 
the session to the client and, consequently, the client can directly communicate with the IRMA server via the `/irma` 
endpoint.

The PbDF maintains its [irmajs](https://github.com/privacybydesign/irmajs) UI.
