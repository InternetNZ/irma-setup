FROM golang:1.14 as irmago

RUN git clone https://github.com/privacybydesign/irmago \
    && cd irmago \
    && go install ./irma \
    && cd ../ \
    && rm -rf irmago

# context: ../
COPY ./irma-setup/wait-for-it.sh /usr/local/bin/wait-for-it
COPY ./irma-setup/build/irmago/jwtkeys/ /irma/jwtkeys

WORKDIR /irma/schemes/inz-demo

COPY ./inz-demo/inz-demo/ /irma/schemes/inz-demo
COPY ./inz-demo/inz-demo/ /root/.local/share/irma/irma_configuration/inz-demo

EXPOSE 8088

