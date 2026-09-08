#!/bin/bash

# Server Conf Vars
export VALHEIM_SERVER=${VALHEIM_SERVER:-'I forgot to name my server'}
export VALHEIM_WORLD=${VALHEIM_WORLD:-'World'}
export VALHEIM_PORT=${VALHEIM_PORT:-2456}
export VALHEIM_PASS=${VALHEIM_PASS}
export VALHEIM_BACKUPS=${VALHEIM_BACKUPS:-5}
export VALHEIM_SAVEINTERVAL=${VALHEIM_SAVEINTERVAL:-1800}

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

if [ -z "${VALHEIM_PASS}" ];then
    echo 'YOU HAVE NOT DEFINED VALHEIM_PASS! Exiting!'
    exit 1
fi

extras=''
if [ "${VALHEIM_CROSSPLAY}" == 1 ];then
    extras="${extras} -crossplay"
fi
if [ "${VALHEIM_PUBLIC}" == 1 ];then
    extras="${extras} -public 1"
fi
if [ -n "${VALHEIM_PRESET}" ];then
    extras="${extras} -preset ${VALHEIM_PRESET}"
fi
if [ -n "${VALHEIM_COMBAT}" ];then
    extras="${extras} -preset ${VALHEIM_COMBAT}"
fi
if [ -n "${VALHEIM_DEATHPENALTY}" ];then
    extras="${extras} -preset ${VALHEIM_DEATHPENALTY}"
fi
if [ -n "${VALHEIM_RESOURCES}" ];then
    extras="${extras} -preset ${VALHEIM_RESOURCES}"
fi
if [ -n "${VALHEIM_RAIDS}" ];then
    extras="${extras} -preset ${VALHEIM_RAIDS}"
fi
if [ -n "${VALHEIM_PORTALS}" ];then
    extras="${extras} -preset ${VALHEIM_PORTALS}"
fi

# Update
/home/steam/steamcmd/steamcmd.sh \
    +force_install_dir ./valheim \
    +login anonymous \
    +app_update 896660 validate \
    +quit

# Launch Server
/home/steam/steamcmd/valheim/valheim_server.x86_64 \
    -nographics -batchmode \
    -name "${VALHEIM_SERVER}" \
    -port ${VALHEIM_PORT} \
    -world "${VALHEIM_WORLD}" \
    -password "${VALHEIM_PASS}" \
    -saveinterval ${VALHEIM_SAVEINTERVAL} \
    -backups ${VALHEIM_BACKUPS} \
    $extras

export LD_LIBRARY_PATH=$templdpath