#!/bin/sh

set -e

/cf-proxy.sh cf login -a $CF_API_ENDPOINT -o $CF_ORG -s $CF_SPACE -u $CF_USERNAME -p $CF_PASSWORD

/cf-proxy.sh cf $*
