# irma commands
FROM golang:1.14

RUN git clone https://github.com/privacybydesign/irmago \
    && cd irmago \
    && go install ./irma \
    && cd ../ \
    && rm -rf irmago

WORKDIR /irma
