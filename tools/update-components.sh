#/bin/bash

source ./tools/config.sh

CAMERA_REPO_URL="https://github.com/espressif/esp32-camera.git"
TINYUSB_REPO_URL="https://github.com/hathach/tinyusb.git"
TINYUSB_REPO_DIR="$AR_COMPS/arduino_tinyusb/tinyusb"
ESP_DSP_REPO_URL="https://github.com/espressif/esp-dsp.git"

#
# CLONE/UPDATE ESP32-CAMERA
#
echo "Updating ESP32 Camera..."
if [ ! -d "$AR_COMPS/esp32-camera" ]; then
       git clone -b master --recursive --depth 1 --shallow-submodule $CAMERA_REPO_URL "$AR_COMPS/esp32-camera"
else
       cd "$AR_COMPS/esp32-camera"
       git pull
       git submodule update --depth 1
       # -ff is for cleaning untracked files as well as submodules
       git clean -ffdx
       cd -
fi
if [ $? -ne 0 ]; then exit 1; fi

#
# CLONE/UPDATE ESP-DSP
#
echo "Updating ESP-DSP..."
if [ ! -d "$AR_COMPS/esp-dsp" ]; then
       git clone -b master --recursive --depth 1 --shallow-submodule $ESP_DSP_REPO_URL "$AR_COMPS/esp-dsp"
else
       cd "$AR_COMPS/esp-dsp"
       git pull
       git submodule update --depth 1
       # -ff is for cleaning untracked files as well as submodules
       git clean -ffdx
       cd -
fi
if [ $? -ne 0 ]; then exit 1; fi

#
# Arduino needs cam_hal.h from esp32-camera in include folder
#
cp "$AR_COMPS/esp32-camera/driver/private_include/cam_hal.h" "$AR_COMPS/esp32-camera/driver/include/"

#
# CLONE/UPDATE TINYUSB
#
echo "Updating TinyUSB..."
if [ ! -d "$TINYUSB_REPO_DIR" ]; then
       git clone -b master --depth 1 "$TINYUSB_REPO_URL" "$TINYUSB_REPO_DIR"
else
       cd $TINYUSB_REPO_DIR
       git pull
       # -ff is for cleaning untracked files as well as submodules
       git clean -ffdx
fi
if [ $? -ne 0 ]; then exit 1; fi
