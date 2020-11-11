# android-builder
Android Builder Image

### Steps to Building APK through this image

#### Create a script to run assemble
```
#!/usr/bin/env bash
set -e

if [[ ! -d /tmp/output ]];
then
  mkdir /tmp/output
fi;

gradle clean assembleDebug

cp app/build/outputs/apk/debug/*.apk /tmp/output
```
save this as build-android.sh


#### Create a Builder Docker
```
FROM kubesailmaker/android-builder:latest as builder

RUN mkdir /workspace
COPY . /workspace
WORKDIR /workspace
RUN chmod a+x ./build-android.sh
CMD ["./build-android.sh"]

```
Save this as Dockerfile in your app folder

#### Build App

```
#!/usr/bin/env bash

BUILDER_IMAGE="builder-$(date +%Y%m%d)"
docker build --no-cache -t $BUILDER_IMAGE .
docker run -v `pwd`/build/output:/tmp/output -it $BUILDER_IMAGE
docker rmi $BUILDER_IMAGE -f || true
```
Save it as build-app.sh

#### Build
```
./build-app.sh
```
