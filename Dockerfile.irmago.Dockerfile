FROM golang:1.14 as irmago

RUN git clone https://github.com/privacybydesign/irmago \
    && cd irmago \
    && go install ./irma \
    && cd ../ \
    && rm -rf irmago

WORKDIR /irma/inz-demo

COPY . .

#RUN irma server --no-tls -s /irma/inz-demo -u http://0.0.0.0:8088/ -vv

EXPOSE 8088

CMD ["irma server --no-tls -s /irma/inz-demo -u http://0.0.0.0:8088/ -vv"]
