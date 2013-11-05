#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author:     Zhang Cheng <cheng.zhang@cloudacc-inc.com>
# Maintainer: Zhang Cheng <cheng.zhang@cloudacc-inc.com>

from subprocess import Popen, PIPE
import sys

# 1. find distro and dist
distro = None
dist = None
for arg in sys.argv:
    if "debian|ubuntu".find(arg) > -1:
        distro = arg
    if "sid|wheezy|squeeze|unstable|testing|stable|oldstable".find(arg) > -1:
        dist = arg
        distro = "debian"
    if "quantal|precise|oneiric|lucid".find(arg) > -1:
        dist = arg
        distro = "ubuntu"

if distro is None or dist is None:
    print "Need to specify 'distro' and 'dist'"
    sys.exit(1)

proc = Popen(["./pkg-reprepro.sh", distro, "list", dist], stdout=PIPE)

pkgs = {}
for line in proc.stdout.readlines():
    arch, name, ver = line.split()
    arch = arch.split("|")[2][:-1]
    if arch == "amd64" or arch == "i386" or arch == "mipsel":
        if not pkgs.has_key(name):
            pkgs[name] = {"amd64": None, "i386": None, "mipsel": None}
        pkgs[name][arch] = ver

print """
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head>
<meta http-equiv="Content-Type" content="text/html"; charset=utf-8>
"""
print "<title>Package list for %s - %s</title>" % (distro, dist)
print """
</head><body><table>
<tr><th>Package</th><th>amd64</th><th>i386</th><th>mipsel</th></tr>
"""

for pkg, vers in sorted(pkgs.items()):
    print "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td>" % (
        pkg,
        vers["amd64"] if vers["amd64"] else "-",
        vers["i386"] if vers["i386"] else "-",
        vers["mipsel"] if vers["mipsel"] else "-"
        )

print """
</table></body></html>
"""

# vim:ai:et:sts=4:sw=4:
