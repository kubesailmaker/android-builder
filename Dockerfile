FROM ubuntu:latest

RUN apt-get update && \
    apt-get -y install curl gnupg2 unzip openjdk-8-jdk

RUN curl -o /tmp/key.pub https://dl.google.com/linux/linux_signing_key.pub && apt-key add /tmp/key.pub

ENV ANDROID_SDK_VERSION r29.0.2
ENV ANDROID_BUILD_TOOLS_VERSION 29.0.2
ENV ANDROID_HOME /opt/app/android-sdk
ENV ANDROID_SDK_HOME /opt/app/android-sdk

ENV GRADLE_HOME /opt/app/gradle

ENV PATH ${PATH}:${GRADLE_HOME}/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN curl -o /tmp/commandlinetools-linux-6858069_latest.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
RUN curl -o /tmp/gradle-6.6.1-bin.zip https://downloads.gradle-dn.com/distributions/gradle-6.6.1-bin.zip
RUN ls -al /tmp

RUN mkdir /opt/app && mkdir /opt/app/java && unzip /tmp/commandlinetools-linux-6858069_latest.zip -d /opt/app/ && unzip /tmp/gradle-6.6.1-bin.zip -d /opt/app/ && \
    mv /opt/app/gradle-6.6.1 /opt/app/gradle && \
    echo y | /opt/app/cmdline-tools/bin/sdkmanager --sdk_root=/opt/app/android-sdk "build-tools;29.0.2" "platforms;android-29" "platforms;android-28" "platforms;android-27" "platforms;android-26" "platforms;android-25" "platforms;android-24" "platforms;android-23" "platforms;android-22" "platforms;android-21" "platforms;android-20" "platforms;android-19"


