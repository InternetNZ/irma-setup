FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y \
        openjdk-8-jdk-headless gradle \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

WORKDIR /etc/ssl/certs/java

# context: ../
COPY irma-setup/certs/ /etc/ssl/certs/
COPY irma-setup/certs/local.internetnz.nz.crt /etc/ssl/certs/java/
RUN keytool -importcert -file local.internetnz.nz.crt -alias local.internetnz.nz.crt -cacerts -storepass changeit -noprompt

WORKDIR /irma_keyshare_server

COPY irma_keyshare_server/gradle /irma_keyshare_server/gradle
COPY irma_keyshare_server/gradlew /irma_keyshare_server
COPY irma_keyshare_server/gradlew.bat /irma_keyshare_server
COPY irma_keyshare_server/build.gradle /irma_keyshare_server

COPY irma_keyshare_server/src /irma_keyshare_server/src

CMD ["./gradlew", "appRun", "--no-daemon", "--no-parallel"]
