#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  SRCDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$SRCDIR/$SOURCE"
done
SRCDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [[ -z "$1" ]]; then
    distro="debian ubuntu"
else
    distro="$1"
fi

for d in $distro; do
    echo "processing incoming for $d"
    BASEDIR=$SRCDIR/../base/$d/
    OUTDIR=$SRCDIR/../www/$d/
    INCOMING=$BASEDIR/incoming/

    REPREPRO="reprepro -b $BASEDIR --outdir $OUTDIR"

    $REPREPRO processincoming default
done

$SRCDIR/pkg-genlist.sh
