# Tasmota Arduino PlatformIO framework builder [![ESP32 builder](https://github.com/Jason2866/esp32-arduino-lib-builder/actions/workflows/push.yml/badge.svg)](https://github.com/Jason2866/esp32-arduino-lib-builder/actions/workflows/push.yml)[![GitHub Releases](https://img.shields.io/github/downloads/Jason2866/esp32-arduino-lib-builder/total?label=downloads)](https://github.com/Jason2866/esp32-arduino-lib-builder/releases/latest)

This repository contains the scripts that produce the libraries included with Tasmota esp32-arduino.

### Build on Ubuntu
```bash
sudo apt update && sudo apt install -y git wget curl libssl-dev libncurses-dev flex bison gperf python3 cmake ninja-build ccache jq
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py && \
pip3 install setuptools pyserial click future wheel cryptography pyparsing pyelftools
git clone https://github.com/Jason2866/esp32-arduino-lib-builder
cd esp32-arduino-lib-builder
./build.sh
```
### Development builds
Look in release and download a version. There is the Info of the used commits of IDF / Arduino.
