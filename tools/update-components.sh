#/bin/bash

source ./tools/config.sh

CAMERA_REPO_URL="https://github.com/espressif/esp32-camera.git"
LITTLEFS_REPO_URL="https://github.com/joltwallet/esp_littlefs.git"
TINYUSB_REPO_URL="https://github.com/hathach/tinyusb.git"
TINYUSB_REPO_DIR="$AR_COMPS/arduino_tinyusb/tinyusb"

#
# CLONE/UPDATE ESP32-CAMERA
#
echo "Updating ESP32 Camera..."
if [ ! -d "$AR_COMPS/esp32-camera" ]; then
       git clone -b master --recursive --depth 1 --shallow-submodule $CAMERA_REPO_URL "$AR_COMPS/esp32-camera"
else
       cd "$AR_COMPS/esp32-camera"
       git fetch --depth 1 origin \
       git reset --hard FETCH_HEAD \
       git submodule update --depth 1 --recursive --init
fi
if [ $? -ne 0 ]; then exit 1; fi

#
# Arduino needs cam_hal.h from esp32-camera in include folder
#
cp "$AR_COMPS/esp32-camera/driver/private_include/cam_hal.h" "$AR_COMPS/esp32-camera/driver/include/"

#
# CLONE/UPDATE ESP-LITTLEFS v1.10.0 commit 032f9...
#
#echo "Updating ESP-LITTLEFS..."
#if [ ! -d "$AR_COMPS/esp_littlefs" ]; then
#	git clone $LITTLEFS_REPO_URL "$AR_COMPS/esp_littlefs"
# 	git -C "$AR_COMPS/esp_littlefs" checkout 032f9eb2e291e7c4df63c3e6a3cb3bc766ded495
#        git -C "$AR_COMPS/esp_littlefs" submodule update --init --recursive
#else
#	git -C "$AR_COMPS/esp_littlefs" fetch
#	git -C "$AR_COMPS/esp_littlefs" pull --ff-only
#        git -C "$AR_COMPS/esp_littlefs" checkout 032f9eb2e291e7c4df63c3e6a3cb3bc766ded495
#        git -C "$AR_COMPS/esp_littlefs" submodule update --init --recursive
#fi
#if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE TINYUSB
#
echo "Updating TinyUSB..."
if [ ! -d "$TINYUSB_REPO_DIR" ]; then
       git clone -b master --depth 1 "$TINYUSB_REPO_URL" "$TINYUSB_REPO_DIR"
else
       cd $TINYUSB_REPO_DIR
       git fetch --depth 1 origin \
       git reset --hard FETCH_HEAD
fi
if [ $? -ne 0 ]; then exit 1; fi
