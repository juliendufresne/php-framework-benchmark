#!/usr/bin/env bash

PROGRAM_NAME=$(basename "$0")
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
USER_DIR="$(pwd)"

function usage()
{
    cat <<EOF
usage: ${PROGRAM_NAME} start|stop|restart|rm
       start    start application
       stop     stop application
       restart  restart application
       rm       remove docker container
EOF
}

action="$1"
[ -z $1 ] && { action="start"; }

cd "${SCRIPT_DIR}"

case "${action}" in
    "clean")
        rm -rf vendor
        rm app/config/parameters.yml
        ;;
    "init")
        echo "Install vendors"
        docker run --rm -v $(pwd):/app composer/composer install
        ;;
    "start")
        echo "Start docker containers"
        /usr/bin/env bash -c "./${PROGRAM_NAME} init"
        docker-compose up -d
        ;;
    "stop")
        echo "Stop docker containers"
        docker-compose stop
        ;;
    "restart")
        /usr/bin/env bash -c "./${PROGRAM_NAME} stop"
        /usr/bin/env bash -c "./${PROGRAM_NAME} start"
        ;;
    "rm")
        /usr/bin/env bash -c "./${PROGRAM_NAME} stop"
        docker-compose rm -f --all
        ;;
    *)
        usage
        exit 1
    ;;
esac

