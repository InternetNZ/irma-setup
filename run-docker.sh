#!/bin/bash

docker_build=''
docker_detach='-d'

docker_command='up';
declare -a compose_files=("-f docker-compose.yml");

for i in "$@"
do
case $i in
    -w=*|--with=*)
    case ${i#*=} in
      "scheme" )
          compose_files=("${compose_files[@]}" "-f docker-compose-scheme.yml") ;;
      "irmago" )
          compose_files=("${compose_files[@]}" "-f docker-compose-irmago.yml") ;;
    esac
    shift
    ;;
    *)
    ;;
esac
case $i in
    -b|--build)
    docker_build='--build'
    shift
    ;;
    *)
    ;;
esac
case $i in
    -ndt|--no-detach)
    docker_detach=''
    shift
    ;;
    *)
    ;;
esac
done

if [[ -n $1 ]]; then
    docker_command=$@
fi

CYAN='\033[0;36m'
NC='\033[0m'

printf "Executing ${CYAN} docker-compose ${compose_files[*]} ${docker_command} ${docker_detach} ${NC}";

docker-compose ${compose_files[*]} ${docker_command} ${docker_detach};
