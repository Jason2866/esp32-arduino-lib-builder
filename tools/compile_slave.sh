#!/bin/bash

# This script is used to build the slave image for wifi_hosted

export IDF_CCACHE_ENABLE=${CCACHE_ENABLE:-1}

rm -rf dependencies.lock

echo "* Installing/Updating ESP-IDF and all components..."

source ./tools/install-esp-idf.sh
if [ $? -ne 0 ]; then exit 1; fi

# use fork until upstream bugs are fixed
git clone --depth 1 https://github.com/Jason2866/esp-hosted-mcu.git || {
  echo "Failed to clone esp-hosted-mcu"; exit 1; }
cd esp-hosted-mcu/slave || exit 1
mkdir wifi_copro_fw

slave_targets=(
    "esp32"
    "esp32s3"
    "esp32c2"
    "esp32c3"
    "esp32c5"
    "esp32c6"
)

for target in "${slave_targets[@]}"; do
    echo "Building for target: $target"
    idf.py set-target "$target"
    idf.py clean
    idf.py build
    cp ./build/network_adapter.bin ./wifi_copro_fw/network_adapter_"$target".bin
    echo "Build completed for target: $target"
done

echo "Extracting firmware version from header…"

INPUT_FILE="./main/esp_hosted_coprocessor_fw_ver.h"
OUTPUT_FILE="./wifi_copro_fw/coprocessor_fw_version.txt"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File $INPUT_FILE not found!"
    exit 1
fi

MAJOR=$(grep "PROJECT_VERSION_MAJOR_1" "$INPUT_FILE" | sed 's/.*PROJECT_VERSION_MAJOR_1 \([0-9]*\).*/\1/')
MINOR=$(grep "PROJECT_VERSION_MINOR_1" "$INPUT_FILE" | sed 's/.*PROJECT_VERSION_MINOR_1 \([0-9]*\).*/\1/')
PATCH=$(grep "PROJECT_VERSION_PATCH_1" "$INPUT_FILE" | sed 's/.*PROJECT_VERSION_PATCH_1 \([0-9]*\).*/\1/')

if [ -z "$MAJOR" ] || [ -z "$MINOR" ] || [ -z "$PATCH" ]; then
    echo "Error: Could not extract all version infos!"
    echo "MAJOR: '$MAJOR', MINOR: '$MINOR', PATCH: '$PATCH'"
    exit 1
fi

VERSION="$MAJOR.$MINOR.$PATCH"
echo "$VERSION" > "$OUTPUT_FILE"

echo "Version $VERSION has been written in $OUTPUT_FILE."

