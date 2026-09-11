#!/bin/bash
image='valheim-server'
name='valheim-server'
envfile='prod.env'

print_help()
{
echo 'Parameters:
    -h|--help          Display this helptext

    -t|--tag <str>     Image tag to target with docker run command.
                       Default: 
    -n|--name <str>    Name to be used for the running container.
                       Default: valheim-server
    -e|--env <file>    Environment file (env vars for the container).
                       Default: prod.env
    -u|--uid <int>     User ID for the container user.
                       Default: steam
    -g|--gid <int>     Group ID for container user.
                       Default: uid
    -p|--port          External port UDP used on the host of the container.
                       Note that port+1 is also used.
                       Default: 2456 (and 2457)
    -v|--volume        Named volume to store World saves and server lists.
                       Default: valheim-world
    -i|--it   Run contianer with -it
    --rm               Run container with --rm flag
    --entry            Change entry to something like /bin/bash for troubleshooting
'
}

# Arguments
extras=''
while (( "$#" )); do
    case "$1" in
        -h|--help) print_help;exit 0;;
        -t|--tag) tag=$2;shift;;
        -n|--name) name=$2;shift;;
        -e|--env) env=$2;shift;;
        -u|--uid) uid=$2;shift;;
        -g|--gid) gid=$2;shift;;
        -p|--port) port=$2;shift;;
        -v|--volume) volume=$2;shift;;
        -i|--it) extras="${extras} -it";shift;;
        --rm) extras="${extras} --rm";shift;;
        --entry) extras="${extras} --entrypoint $2";shift;;
    esac
    shift
done

# Check if image exists
if [ $(docker images --format 'table'|grep -c ${image}) -lt 1 ];then
    echo 'Image is missing! Build it before running this script!'
fi

# Default values
if [ -z "${tag}" ];then
    tag="$(docker images --format table|grep $image|head -n 1|awk '{print $2}')"
    echo "No tag provided and found: '${tag}'"
fi
if [ -z "${name}" ];then name=${image};fi
if [ -z "${envfile}" ];then
    envfile='prod.env'
    echo "Environment file not provided with -e, so using '${envfile}'"
fi
if [ -z "${uid}" ];then uid="${USERID:-1000}";fi
if [ -z "${gid}" ];then gid="${GROUPID:-$uid}";fi
if [ -z "${port}" ];then port_a=2456;fi
port_b=$(($port_a+1))
port_c=$(($port_a+2))
if [ -z "${volume}" ];then volume='valheim-world';fi


# Execute Docker Run
echo "Starting container image: '${image}:${tag}' with env: '${envfile}'"
echo ''
set -x
docker run --name ${name} \
    --user "${uid}:${gid}" \
    -p 2456:${port_a}/udp \
    -p 2457:${port_b}/udp \
    -p 2458:${port_c}/udp \
    -v $volume:/home/steam/.config/unity3d/IronGate/Valheim \
    --env-file ${envfile} ${extras} \
    ${image}:${tag}
