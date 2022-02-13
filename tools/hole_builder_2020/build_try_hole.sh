#!/bin/bash

SRC_DIR="/users/nick/Dropbox/C64/Projects/Backburner/PGA/src"
HOLES_DIR="/users/nick/Dropbox/C64/Projects/Backburner/PGA/assets/holes"

cd ${HOLES_DIR}
exomizer level -otryhole.prg tryhole.bin
cd ${SRC_DIR}
c1541 mydisk.d64 -delete tryhole.prg -write ${HOLES_DIR}/tryhole.prg


