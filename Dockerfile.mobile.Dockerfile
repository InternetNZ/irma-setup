FROM golang:1.14-alpine

COPY wait.sh /usr/bin/wait.sh

RUN apk update \
    && apk add git nodejs npm \
    bash

RUN apk --no-cache add openjdk11 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

WORKDIR /app

RUN npm install -g react-native-cli yarn

RUN yarn install

ARG android_api=29
ARG android_build_tools=29.0.2

ENV ANDROID_SDK_ROOT /opt/android-sdk-linux
ENV ANDROID_HOME $ANDROID_SDK_ROOT
ENV GLIBC 2.25-r0
ENV PATH $PATH:$ANDROID_SDK_ROOT/tools/bin

RUN apk add --no-cache --virtual=.build-dependencies \
        bash \
        file \
        git \
        git-lfs \
        openssl \
        wget \
        unzip \
    && wget --quiet https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -O /etc/apk/keys/sgerrand.rsa.pub \
    && wget --quiet https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC}/glibc-${GLIBC}.apk -O /tmp/glibc.apk \
    && wget --quiet https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC}/glibc-bin-${GLIBC}.apk -O /tmp/glibc-bin.apk \
    && apk add --no-cache /tmp/glibc.apk /tmp/glibc-bin.apk \
    && rm -rf /tmp/* /var/cache/apk/* \
    && openssl version

RUN wget --quiet https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O /tmp/tools.zip \
    && mkdir -p $ANDROID_SDK_ROOT \
    && unzip -q /tmp/tools.zip -d $ANDROID_SDK_ROOT \
    && rm -v /tmp/tools.zip \
    && mkdir -p /root/.android/ \
    && touch /root/.android/repositories.cfg
#RUN yes | sdkmanager \
#        "build-tools;${android_build_tools}" \
#        "platforms;android-${android_api}" >/dev/null \
#    && rm -rf  \
#        # Delete proguard docs and examples
#        $ANDROID_SDK_ROOT/tools/proguard/examples \
#        $ANDROID_SDK_ROOT/tools/proguard/docs \
#    && sdkmanager --list | sed -e '/Available Packages/q'

# TODO: Prepare JAVA_HOME
# TODO: Prepare talking to adb/device that is running outside the docker container

CMD ["sh", "/usr/bin/wait.sh"]
