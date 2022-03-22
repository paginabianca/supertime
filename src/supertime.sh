#!/bin/sh

# Measure the time taken by executing an Ansible playbook.
# Tries to find git hash and mark it.
# Times are appended to FILE

set -eou pipefail

FILE=~/.local/share/supertime/supertime.csv
TIME_ARGS='-f%U,%S,%P,%E,%C,%x'
HASH=""

if [ ! -d ~/.cache/supertime ]; then
    mkdir -p ~/.cache/supertime
fi

if [ ! -d "$(dirname ${FILE})" ]; then
    mkdir -p "$(dirname ${FILE})"
fi

if [ ! -e ${FILE} ]; then
    touch ${FILE}
    echo "User Time,System Time,CPU,Total Time,Command/File,Exit Code,Commit;" > $FILE
fi

if [ -z "$@" ]; then
    echo "First argument has to be file to be executed."
    exit 1
fi

if git status 2>/dev/null 1>/dev/null; then
    # CWD is GIT VCS
    if  [ -n "$(git status --porcelain 2>&1)" ]; then
      # Uncommitted changes
      echo "Git dir should be clean. Commit all you changes and try again."
      exit 1
    else
        HASH=$(git rev-parse --short HEAD)
    fi
fi

UUID=~/.cache/supertime/$(uuidgen)
touch $UUID
/usr/bin/time --output-file="${UUID}" "${TIME_ARGS}" "$1"

MEASUREMENT="$(/usr/bin/cat "${UUID}"),$HASH;"

echo "$MEASUREMENT" >> ${FILE}
