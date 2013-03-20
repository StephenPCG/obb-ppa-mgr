#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  SRCDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$SRCDIR/$SOURCE"
done
SRCDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [[ "$1" != "debian" && "$1" != "ubuntu" ]]; then
    echo "\$1 is not 'debian' or 'ubuntu', assuming 'debian'"
    distro=debian
else
    distro=$1
    shift
fi

BASEDIR=$SRCDIR/../base/$distro/
OUTDIR=$SRCDIR/../www/$distro/
INCOMING=$BASEDIR/incoming/

REPREPRO="reprepro -b $BASEDIR --outdir $OUTDIR"

$REPREPRO $@

