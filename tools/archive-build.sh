#!/bin/bash

IDF_COMMIT=$(git -C "$IDF_PATH" rev-parse --short HEAD || echo "")
IDF_BRANCH=$(git -C "$IDF_PATH" symbolic-ref --short HEAD || git -C "$IDF_PATH" tag --points-at HEAD || echo "")

idf_version_string=${IDF_BRANCH//\//_}"-$IDF_COMMIT"
archive_path="dist/arduino-esp32-libs-ITEAD-$idf_version_string.tar.gz"
build_archive_path="dist/arduino-esp32-build-ITEAD-$idf_version_string.tar.gz"
pio_archive_path="dist/framework-arduinoespressif32-ITEAD-$idf_version_string.tar.gz"
pio_zip_archive_path="dist/framework-arduinoespressif32-ITEAD-$idf_version_string.zip"

mkdir -p dist && rm -rf "$archive_path" "$build_archive_path"

cd out
echo "Creating PlatformIO Tasmota framework-arduinoespressif32-ITEAD"
cp -rf ../components/arduino arduino-esp32
rm -rf arduino-esp32/docs
rm -rf arduino-esp32/tests
rm -rf arduino-esp32/libraries/RainMaker
rm -rf arduino-esp32/libraries/Insights
rm -rf arduino-esp32/package
rm -rf arduino-esp32/tools/sdk
rm -rf arduino-esp32/tools/esptool.py
rm -rf arduino-esp32/tools/gen_esp32part.py
rm -rf arduino-esp32/tools/gen_insights_package.py
rm -rf arduino-esp32/tools/gen_insights_package.exe
rm -rf arduino-esp32/tools/platformio-build-*.py
rm -rf arduino-esp32/platform.txt
rm -rf arduino-esp32/programmers.txt
rm -rf arduino-esp32/boards.txt
rm -rf arduino-esp32/package.json
rm -rf arduino-esp32/*.md
mv -f tools/esp32-arduino-libs/platformio-build-*.py arduino-esp32/tools/
cp -f tools/gen_esp32part.py arduino-esp32/tools/
cp -Rf tools/esp32-arduino-libs/ arduino-esp32/tools/sdk
cp ../package.json arduino-esp32/package.json
cp ../core_version.h arduino-esp32/cores/esp32/core_version.h
mv arduino-esp32/ framework-arduinoespressif32/
# If the framework is needed as tar.gz uncomment next line
# tar --exclude=.* -zcf ../$pio_archive_path framework-arduinoespressif32/
7z a -mx=9 -tzip -xr'!.*' ../$pio_zip_archive_path framework-arduinoespressif32/
