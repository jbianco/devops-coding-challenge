#!/usr/bin/env bash

url=''
path='/v1/healthcheck'

## Color definitions ##
CSTDR="\033[0m"
CERR="\033[0;31m"
COK="\033[0;32m"
CWAR="\033[0;33m"
CDBG="\033[0;34m"

log(){
        echo -e $1
}

create_message(){
        message_type=$1
        message_color=$2
        message=$3
        echo "$message_color$(echo "$message_type"|awk '{print toupper($0)}'): $message$CSTDR"
}

info(){
        message=$1
        message_type="INFO"
        log "$(create_message $message_type $COK "$message")"
}

warn(){
        message=$1
        message_type="WARNING"
        log "$(create_message $message_type $CWAR "$message")"
}

error(){
        message=$1
        message_type="ERROR"
        log "$(create_message $message_type $CERR "$message")"
}

usage(){
    loglevel=$1
    $loglevel "Usage:"
    $loglevel "\t$0 -u <URL> [-p <PATH TO HEALTHCHECK>]"
    $loglevel "\t-c FILE\tUse a specific Terraform .tfvars config FILE"
    $loglevel "\t-d\tEnable terraform debug mode"
    $loglevel "\t-f\tForce apply without running plan"
}

while getopts "h?u:p:" opt; do
    case "$opt" in
    h|\?)
        usage "info"
        exit 0
        ;;
    u)  url="${OPTARG}"
        ;;
    p)  path="${OPTARG}"
        ;;
    esac
done

if [[ -z ${url} ]]
then
    error "URL is a mandatory parameter, please complete this parameter and run it again"
    usage "error"
    exit 1
fi

status=$(curl -I "$url/$path" 2>/dev/null | head -n 1 | cut -d$' ' -f2)

if [[ "$status" -eq "200" ]]
then
    info "The service is properly working"
else
    error "The service is not reachable, please check"
    exit 1
fi