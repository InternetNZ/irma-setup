FROM openjdk:8-alpine

RUN apk add --no-cache git

# context: ../
WORKDIR /irma_keyshare_server

COPY irma_keyshare_server/gradle /irma_keyshare_server/gradle
COPY irma_keyshare_server/gradlew /irma_keyshare_server
COPY irma_keyshare_server/gradlew.bat /irma_keyshare_server
COPY irma_keyshare_server/build.gradle /irma_keyshare_server

COPY irma_keyshare_server/src /irma_keyshare_server/src

COPY inz-demo/inz-demo /irma_keyshare_server/src/main/resources/irma_configuration/inz-demo
RUN git clone https://github.com/privacybydesign/irma-demo-schememanager /irma_keyshare_server/src/main/resources/irma_configuration/irma-demo

CMD ["./gradlew", "appRun", "--no-daemon", "--info", "--no-parallel"]
