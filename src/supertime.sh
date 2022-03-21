#!/bin/sh

# Measure the time taken by executing an Ansible playbook.
# Tries to find git hash and mark it.
# Times are appended to FILE

set -eou pipefail

FILE=~/.local/share/timings
TIME_ARGS='-f %U,%S,%P,%E,%C,%x --'
HASH=""

if [ ! -d ~/.cache/supertime ]; then
    mkdir -p ~/.cache/supertime
fi

if [ ! -s ~/.local/share/supertime ]; then
    mkdir -p ~/.local/share/supertime
fi

if [ ! -e ~/.local/share/supertime/timings.csv ]; then
    echo "User Time,System Time,CPU,Total Time,Command/File,Commit;" >> ~/.local/share/supertime/timings.csv
fi

if [ -z $1 ]; then
    echo "First argument has to be file to be executed."
    exit -1
fi

if $(git status 2>/dev/null 1>/dev/null); then
    # CWD is GIT VCS
    if  [ -n "$(git status --porcelain 2>&1)" ]; then
      # Uncommitted changes
      echo "Git dir should be clean. Commit all you changes and try again."
      exit -1
    else
        HASH=$(git rev-parse --short)
    fi
fi

UUID=~/.cache/supertime/$(uuidgen)
touch $UUID
TIME=$(/usr/bin/time --output-file=${UUID} ${TIME_ARGS} $1)

if [ ! -z $HASH ]; then
    echo "hash is nonzero '$HASH'"
    MEASUREMENT="$(/usr/bin/cat ${UUID}),$HASH;"
else
    echo "hash zero '$HASH'"
    MEASUREMENT="$(/usr/bin/cat ${UUID});"
fi

echo "$MEASUREMENT" >> ${FILE}
