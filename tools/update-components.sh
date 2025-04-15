#/bin/bash

source ./tools/config.sh

TINYUSB_REPO_URL="https://github.com/hathach/tinyusb.git"
TINYUSB_REPO_DIR="$AR_COMPS/arduino_tinyusb/tinyusb"

#
# CLONE/UPDATE TINYUSB
#
echo "Updating TinyUSB..."
if [ ! -d "$TINYUSB_REPO_DIR" ]; then
       git clone -b master "$TINYUSB_REPO_URL" "$TINYUSB_REPO_DIR"
       cd "$TINYUSB_REPO_DIR"
       git checkout 6689a0142dfbb2cf2bb8f7f7e4f4ae8d019648a9
       cd -
else
       cd $TINYUSB_REPO_DIR
       git pull
       # -ff is for cleaning untracked files as well as submodules
       git clean -ffdx
       git checkout 6689a0142dfbb2cf2bb8f7f7e4f4ae8d019648a9
       cd -
fi
if [ $? -ne 0 ]; then exit 1; fi
