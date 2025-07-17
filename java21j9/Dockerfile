FROM        --platform=$TARGETOS/$TARGETARCH ibm-semeru-runtimes:open-21-jdk

LABEL       author="KrArjan" maintainer="krarjanofficial@gmail.com"

LABEL       org.opencontainers.image.source="https://github.com/pterodactyl/yolks"
LABEL       org.opencontainers.image.licenses=MIT

RUN                             apt-get update -y \
                                                && apt-get install -y lsof curl ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 unzip \
                                                && useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]