FROM golang:1.14 as irmago

#ENV IRMASERVER_REQUESTORS='{"keyshare_server":{"auth_method":"publickey","key_file":"/home/rafael/go/src/github.com/privacybydesign/irmago/testdata/jwtkeys/kss-pk.pem"},"site":{"auth_method":"publickey","key_file":"/home/rafael/go/src/github.com/privacybydesign/irmago/testdata/jwtkeys/kss-pk.pem"}}'
ENV IRMASERVER_NO_AUTH=false

COPY wait-for-it.sh /usr/local/bin/wait-for-it

RUN git clone https://github.com/privacybydesign/irmago \
    && cd irmago \
    && go install ./irma \
    && cd ../ \
    && rm -rf irmago

WORKDIR /irma/inz-demo

COPY inz-demo/ /irma/inz-demo
COPY inz-demo/ /root/.local/share/irma/irma_configuration/inz-demo

#RUN wait-for-it proxy:80 -- irma server -u http://0.0.0.0:8088/ -vv

EXPOSE 8088

#CMD ["/usr/local/bin/wait-for-it proxy:80 -- irma server -u http://0.0.0.0:8088/ -vv"]
