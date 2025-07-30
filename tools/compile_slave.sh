#!/bin/bash

# This script is used to build the slave image for wifi_hosted

export IDF_CCACHE_ENABLE=${CCACHE_ENABLE:-1}

rm -rf dependencies.lock

echo "* Installing/Updating ESP-IDF and all components..."

source ./tools/install-esp-idf.sh
if [ $? -ne 0 ]; then exit 1; fi

git clone https://github.com/Jason2866/esp-hosted-mcu.git
cd ./esp-hosted-mcu/slave

slave_targets=(
    "esp32"
    "esp32s3"
    "esp32c2"
    "esp32c3"
    "esp32c5"
    "esp32c6"
)

# idf.py create-project-from-example "espressif/esp_hosted:slave"
idf.py build
mkdir wifi_copro_fw

echo "Found firmware version: $(<./main/coprocessor_fw_version.txt)"

for target in "${slave_targets[@]}"; do
    echo "Building for target: $target"
    idf.py set-target "$target"
    idf.py clean
    idf.py build
    cp ./build/network_adapter.bin ../wifi_copro_fw/network_adapter_"$target".bin
    echo "Build completed for target: $target"
done

cp ./main/coprocessor_fw_version.txt ../wifi_copro_fw/coprocessor_fw_version.txt
