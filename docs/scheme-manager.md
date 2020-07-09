# IRMA Scheme Manager

a.k.a. [irma-demo-scheme](https://github.com/InternetNZ/inz-demo-scheme)

The responsibility of the scheme manager is to maintain the information of one ore more IRMA schemes and distribute it 
to relevant parties. Anyone can start a new scheme, and consequently, become the scheme manager for that scheme.

The PbDF maintains its scheme called [“pbdf-schememanager”](https://github.com/privacybydesign/pbdf-schememanager), which the IRMA app uses by default.

## Server

A scheme manager web server should be online because it is required. IRMA components that have the scheme installed 
will periodically update their local version of the scheme using this remote copy.

## Specifications

https://irma.app/docs/schemes/
