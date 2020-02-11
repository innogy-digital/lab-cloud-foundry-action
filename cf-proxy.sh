#!/usr/bin/env bash
set -e -o pipefail

LOCAL_PROXY_PORT=$(shuf -i 20000-65000 -n 1)

SSH_PID=

print_help() {
  echo "$0 help | cf [global options] Befehl [arguments...] [command options]"
  echo "This is a helper script to access a pcf cloud installation by a ssh socks proxy."
  echo
  echo "please set these Environment variables:"
  echo "* SSH_PROXY_SERVER"
  echo "* SSH_PROXY_USER"
  echo "* SSH_PROXY_PEM"
  echo
}

start_proxy() {
  PORT=$1
  FOREGROUND=$2

  echo
  echo "###############################################"
  echo "SOCKS5 proxy starting on PORT $PORT..."
  echo "###############################################"
  echo

  ssh   ${SSH_PROXY_USER}@${SSH_PROXY_SERVER} \
        -D ${PORT} \
        -N \
        -o StrictHostKeyChecking=no &

  SSH_PID=$!
  sleep 1

  echo
  if $(ps $SSH_PID 2>&1 > /dev/null); then
    echo "done."
  else
    echo "error. Exit."
    exit 1
  fi
  echo
}

function stop_proxy() {
  test "x$SSH_PID" == "x" && return

  echo
  echo -n "Stopping SOCKS5 proxy with PID ${SSH_PID}..."
  kill $SSH_PID
  echo " done"

  SSH_PID=
}

trap stop_proxy SIGINT SIGTERM EXIT

if [ "$#" -lt 1 ]; then
    print_help
    exit 1
fi

if [ -z "$SSH_PROXY_SERVER" ] || [ -z "$SSH_PROXY_USER" ] || [ -z "$SSH_PROXY_PEM" ]; then
    echo "ERROR, missing env variables."
    echo
    print_help
    exit 1
fi

source <(ssh-agent)
echo "$SSH_PROXY_PEM" | ssh-add -

if [[ "$1" =~ ^cf.* ]]; then
  start_proxy $LOCAL_PROXY_PORT false
  export https_proxy="socks5://localhost:${LOCAL_PROXY_PORT}"
  export ALL_PROXY="socks5://localhost:${LOCAL_PROXY_PORT}"

  "$@"

else
  print_help
fi


