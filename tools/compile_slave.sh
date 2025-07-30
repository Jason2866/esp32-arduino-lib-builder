#!/bin/bash

# This script is used to build the slave image for wifi_hosted

export IDF_CCACHE_ENABLE=${CCACHE_ENABLE:-1}

rm -rf dependencies.lock

echo "* Installing/Updating ESP-IDF and all components..."

source ./tools/install-esp-idf.sh
if [ $? -ne 0 ]; then exit 1; fi

git clone https://github.com/Jason2866/esp-hosted-mcu.git
cd esp-hosted-mcu/slave

slave_targets=(
    "esp32"
    "esp32s3"
    "esp32c2"
    "esp32c3"
    "esp32c5"
    "esp32c6"
)

# idf.py create-project-from-example "espressif/esp_hosted:slave"
mkdir wifi_copro_fw
# cd ./slave
echo "Found firmware version: $(<./main/coprocessor_fw_version.txt)"

for target in "${slave_targets[@]}"; do
    echo "Building for target: $target"
    idf.py set-target "$target"
    idf.py clean
    idf.py build
    cp ./build/network_adapter.bin ./wifi_copro_fw/network_adapter_"$target".bin
    echo "Build completed for target: $target"
done

INPUT_FILE="./main/coprocessor_fw_version.h"
OUTPUT_FILE="./wifi_copro_fw/coprocessor_fw_version.txt"

# Prüfen ob Eingabedatei existiert
if [ ! -f "$INPUT_FILE" ]; then
    echo "Fehler: Datei $INPUT_FILE nicht gefunden!"
    exit 1
fi

# Versionsnummern extrahieren
MAJOR=$(grep "PROJECT_VERSION_MAJOR_1" "$INPUT_FILE" | sed 's/.*PROJECT_VERSION_MAJOR_1 \([0-9]*\).*/\1/')
MINOR=$(grep "PROJECT_VERSION_MINOR_1" "$INPUT_FILE" | sed 's/.*PROJECT_VERSION_MINOR_1 \([0-9]*\).*/\1/')
PATCH=$(grep "PROJECT_VERSION_PATCH_1" "$INPUT_FILE" | sed 's/.*PROJECT_VERSION_PATCH_1 \([0-9]*\).*/\1/')

# Prüfen ob alle Werte gefunden wurden
if [ -z "$MAJOR" ] || [ -z "$MINOR" ] || [ -z "$PATCH" ]; then
    echo "Fehler: Konnte nicht alle Versionsnummern extrahieren!"
    echo "MAJOR: '$MAJOR', MINOR: '$MINOR', PATCH: '$PATCH'"
    exit 1
fi

# Version zusammensetzen und in Datei schreiben
VERSION="$MAJOR.$MINOR.$PATCH"
echo "$VERSION" > "$OUTPUT_FILE"

echo "Version $VERSION wurde in $OUTPUT_FILE geschrieben."

