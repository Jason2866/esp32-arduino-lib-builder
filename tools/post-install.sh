#!/bin/bash
source ./tools/config.sh

if [ -d "out" ]; then
    cd out
    echo "POST INSTALL"
    AR_BRANCH_SUFFIX = "idf-$IDF_BRANCH"
    #AR_BRANCH_SUFFIX=${AR_BRANCH_SUFFIX%"$-solo1"}
    #git clone "https://github.com/espressif/arduino-esp32 -b $AR_BRANCH_SUFFIX"
    git clone "https://github.com/espressif/arduino-esp32 -b master"
    rm -rf arduino-esp32/tools/sdk
    cp -Rf tools/sdk arduino-esp32/tools/sdk
    tar --exclude=".*" -zcvf arduino-esp32.tar.gz arduino-esp32/
    cd ..
fi
