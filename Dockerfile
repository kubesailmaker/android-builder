FROM ubuntu:latest

RUN apt-get update && \
    apt-get -y install curl gnupg2 unzip openjdk-8-jdk

RUN curl -o /tmp/key.pub https://dl.google.com/linux/linux_signing_key.pub && apt-key add /tmp/key.pub

ENV ANDROID_SDK_VERSION r29.0.2
ENV ANDROID_BUILD_TOOLS_VERSION 29.0.2
ENV ANDROID_SDK_FILENAME android-sdk_${ANDROID_SDK_VERSION}-linux.tgz
ENV ANDROID_SDK_URL https://dl.google.com/android/${ANDROID_SDK_FILENAME}
ENV ANDROID_API_LEVELS=android-26,android-27,android-28,android-29
ENV ANDROID_HOME /opt/app/android-sdk

ENV GRADLE_HOME /opt/app/gradle

ENV PATH ${PATH}:${GRADLE_HOME}/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN curl -o /tmp/commandlinetools-linux-6858069_latest.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
RUN curl -o /tmp/gradle-6.6.1-bin.zip https://services.gradle.org/distributions/gradle-6.6.1-bin.zip

RUN mkdir /opt/app && mkdir /opt/app/java && unzip /tmp/commandlinetools-linux-6858069_latest.zip -d /opt/app/ && unzip /tmp/gradle-6.6.1-bin.zip -d /opt/app/ && \
    mv /opt/app/gradle-6.6.1 /opt/app/gradle && \
    echo y | /opt/app/cmdline-tools/bin/sdkmanager --sdk_root=/opt/app/android-sdk "build-tools;29.0.2" "platforms;android-29" "platforms;android-28" "platforms;android-27"

