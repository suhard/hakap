#!/bin/bash

## Variable definition
WORKER_LIST="worker.list"

## Check file from parameters
if [ ! -f $WORKER_LIST ]; then
        echo_err "Worker list file ($WORKER_LIST) not exists."
                exit 1
fi

## Check the file contents
if [ ! -s $WORKER_LIST ]; then
        echo_err "Worker list file ($WORKER_LIST) is empty."
                exit 1
fi

## Create array from file
readarray WORKER < $WORKER_LIST

## Install Docker on each worker
for WORKERNAME in ${WORKER[@]}; do
        ssh $WORKERNAME -o "StrictHostKeyChecking no" -oUserKnownHostsFile=/dev/null \
                "bash -s" < install_docker.sh
done
