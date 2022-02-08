#!/bin/sh

LIB="Plugin"
DST="../Assets"
FLAGS="-O2 -Wall -shared -framework Foundation -framework Metal"

set -e
set -x

gcc ${FLAGS} Plugin.m --target="x86_64-apple-macos10.12" -o x86_64.dylib
gcc ${FLAGS} Plugin.m --target="arm64-apple-macos10.12" -o arm64.dylib

lipo -create -output ${LIB}.bundle x86_64.dylib arm64.dylib

DST_FILE="${DST}/${LIB}.bundle"
[ -e $DST_FILE ] && rm $DST_FILE
cp ${LIB}.bundle $DST_FILE
