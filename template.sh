#!/bin/bash -e

# Enable more detail execution trace
export PS4='+ [$(basename ${BASH_SOURCE})] [${LINENO}] '

# Define error codes
ERROR_CODE_REQUIRED_PARAM_NOT_ASSIGNED=1
ERROR_CODE_B=2
ERROR_CODE_C=3

SCRIPT=$(basename $0)
function usage() {
    cat << EOF
Usage: $SCRIPT [-a|--a-long] [-b|--longb] [--dry-run|-n]

DESCRIPTION HERE.

Options:
    -a|--a-long         DESCRIPTION HERE
    -b|--longb          DESCRIPTION HERE

    -v|--verbase        Verbose mode.
    -n|--dry-run        Dry-run mode.
    -h|--help           Show this help document

Example:
1> Description here:
    $SCRIPT -ab -v
2> Description here:
    $SCRIPT -a -b -v -n
EOF
    exit 0
}

[ $# -eq 0 ] && usage

ARGS=$(getopt -n $SCRIPT -o abhnv -l a-long,longb,verbose,dry-run,help -- $@)
eval set -- "$ARGS"
VERBOSE_MODE="false"
DRYRUN_MODE="false"
while [ $# -gt 0 ]; do
    case $1 in
        -a|--a-long)
            OPTION_A=$2
            ;;
        -b|--longb)
            OPTION_B=$2
            ;;
        -v|--verbose)
            VERBOSE_MODE="true"
            ;;
        -n|--dry-run)
            DRYRUN_MODE="true"
            ;;
        -h|--help)
            usage
            ;;
        --)
            shift
            break
            ;;
    esac
    shift
done

COLOR_DEFAULT="\e[00;39m"
COLOR_RED="\e[00;31m"
COLOR_YELLOW="\e[00;33m"

function log_i() {
    echo -e "Info : $*"
}

function log_w() {
    echo -e "${COLOR_YELLOW}Warn : $*${COLOR_DEFAULT}"
}

function log_e() {
    echo -e "${COLOR_RED}Error: $*${COLOR_DEFAULT}"
}

function check_env() {
    local _RET_CODE=
    local _VALUE=
    local _REQUIRED_PARAMS=$(cat << EOL
OPTION_A
EOL
)
    local _OPTIONAL_PARAMS=$(cat << EOL
OPTION_B
EOL
)

    _RET_CODE=0

    # Check optional parameters
    printf "%-100s\n" "-" | sed "s| |-|g"
    printf "%-30s%-70s\n" "Parameter" "Value (OPTIONAL)"
    printf "%-100s\n" "-" | sed "s| |-|g"
    for I in $(echo $_REQUIRED_PARAMS); do
        _VALUE=$(eval echo \$$I)
        printf "%-25s  :  %-70s\n" "$I" "$_VALUE"
    done 
    printf "%-100s\n" "-" | sed "s| |-|g"
    for I in $(echo $_REQUIRED_PARAMS); do
        _VALUE=$(eval echo \$$I)
        if [ -z "$_VALUE" ]; then 
            log_w "unassigned optional parameter found: $I"
        fi
    done 

    log_i

    # Check required parameters
    printf "%-100s\n" "-" | sed "s| |-|g"
    printf "%-30s%-70s\n" "Parameter" "Value (REQUIRED)"
    printf "%-100s\n" "-" | sed "s| |-|g"
    for I in $(echo $_REQUIRED_PARAMS); do
        _VALUE=$(eval echo \$$I)
        printf "%-25s  :  %-70s\n" "$I" "$_VALUE"
    done 
    printf "%-100s\n" "-" | sed "s| |-|g"
    for I in $(echo $_REQUIRED_PARAMS); do
        _VALUE=$(eval echo \$$I)
        if [ -z "$_VALUE" ]; then 
            log_e "unassigned required parameter found: $I"
            _RET_CODE=$ERROR_CODE_REQUIRED_PARAM_NOT_ASSIGNED
        fi
    done 

    # Check other conditions
    until false; do
        #
        # CHECKING DETAILS
        #

        break
    done

    return $_RET_CODE
}

function __level2_func() {
    local _RET_CODE=

    _RET_CODE=0

    #
    # PROCESS DETAILS
    #

    return $_RET_CODE
}

function _leve1_func() {
    local _RET_CODE=

    _RET_CODE=0

    #
    # PROCESS DETAILS
    #

    return $_RET_CODE
}


function enter_process() {
    local _RET_CODE=

    _RET_CODE=0

    #
    # PROCESS DETAILS
    #

    return $_RET_CODE
}


CUR_DIR=$(pwd)
EXIT_CODE=0

if check_env; then
    eval "$VERBOSE_MODE" && set -x

    enter_process
fi

exit $EXIT_CODE

# vim: set shiftwidth=4 tabstop=4 expandtab
