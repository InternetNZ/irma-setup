FROM openjdk:8-alpine

# context: ../
WORKDIR /app

COPY irma_keyshare_server/gradle /app/gradle
COPY irma_keyshare_server/gradlew /app
COPY irma_keyshare_server/gradlew.bat /app
COPY irma_keyshare_server/build.gradle /app

COPY irma_keyshare_server/src /app/src

COPY inz-demo/inz-demo /app/src/main/resources/irma_configuration/inz-demo

CMD ["./gradlew", "appRun", "--no-daemon", "--no-parallel"]
