#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  SRCDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$SRCDIR/$SOURCE"
done
SRCDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

pushd $SRCDIR > /dev/null

if [[ ! -r upload.conf ]]; then
    echo "there is not upload.conf, exit"
    exit 0
fi

srcdir="../www/"

while read host dstdir; do
    if [[ -z "$host" || -z "$dstdir" ]]; then
        continue
    fi
    echo "uploading to $host:$dstdir ..."
    rsync -av --progress $srcdir $host:$dstdir
done < upload.conf

popd > /dev/null 

# vim:ai:et:sts=4:tw=80:sw=4:
