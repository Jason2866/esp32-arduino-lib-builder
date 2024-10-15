#/bin/bash

source ./tools/config.sh

TINYUSB_REPO_URL="https://github.com/hathach/tinyusb.git"
TINYUSB_REPO_DIR="$AR_COMPS/arduino_tinyusb/tinyusb"

#
# CLONE/UPDATE TINYUSB
#
echo "Updating TinyUSB..."
if [ ! -d "$TINYUSB_REPO_DIR" ]; then
       git clone -b master --depth 1 "$TINYUSB_REPO_URL" "$TINYUSB_REPO_DIR"
       cd "$TINYUSB_REPO_DIR"
       git checkout a4fb8354e41b2604f66e7da22afa292b1a44f0a2
       cd -
else
       cd $TINYUSB_REPO_DIR
       git pull
       # -ff is for cleaning untracked files as well as submodules
       git clean -ffdx
       git checkout a4fb8354e41b2604f66e7da22afa292b1a44f0a2
fi
if [ $? -ne 0 ]; then exit 1; fi
