FROM golang:1.14-alpine as irmago

ARG TAG_VERSION='v0.7.0'

RUN apk add --no-cache bash git

RUN git clone --branch $TAG_VERSION https://github.com/privacybydesign/irmago \
    && cd irmago \
    && go install ./irma \
    && cd ../ \
    && rm -rf irmago

# context: ../
COPY irma-setup/wait-for-it.sh /usr/local/bin/wait-for-it
COPY irma-setup/build/irmago/jwtkeys/ /irma/jwtkeys

WORKDIR /irma/schemes/inz-demo

COPY inz-demo/inz-demo/ /irma/schemes/inz-demo
RUN git clone https://github.com/privacybydesign/irma-demo-schememanager /irma/schemes/irma-demo

EXPOSE 8088

