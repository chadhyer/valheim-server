#!/bin/bash

docker run --rm -it \
    --name valheim-server \
    -p 2456:2456/udp \
    -p 2457:2457/udp \
    --env-file ./prod.env \
    --user steam:steam \
    -v valheim-world:/home/steam/.config/unity3d/IronGate/Valheim \
    valheim-server:v0
