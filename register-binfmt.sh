#!/bin/sh

echo ':c64ext:E::prg::/usr/bin/x64sc:' > /proc/sys/fs/binfmt_misc/register
echo ':c64:M::\x08\x01::/usr/bin/x64sc:' > /proc/sys/fs/binfmt_misc/register
