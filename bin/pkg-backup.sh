#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  SRCDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$SRCDIR/$SOURCE"
done
SRCDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

pushd $SRCDIR > /dev/null

[[ -r "personal.conf" ]] && source personal.conf

if [[ -z "$BACKUPBASE" ]]; then
    read -p "basedir to backup: " BACKUPBASE
fi

BACKUPDIR="$BACKUPBASE/$(date +%Y%m%d%H%M)"

rsync -av --progress ../www/ $BACKUPDIR/

popd > /dev/null 

# vim:ai:et:sts=4:tw=80:sw=4:
