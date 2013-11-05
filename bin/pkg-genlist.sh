#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  SRCDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$SRCDIR/$SOURCE"
done
SRCDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

pushd $SRCDIR > /dev/null

echo "generating package list page for debian"
for dist in oldstable stable unstable; do
    python ./pkg-genlist.py debian $dist > ../www/debian/packages.$dist.html
done

echo "generating package list page for ubuntu"
for dist in lucid; do
    python ./pkg-genlist.py ubuntu $dist > ../www/ubuntu/packages.$dist.html
done

popd > /dev/null

# vim:ai:et:sts=4:tw=80:sw=4:
