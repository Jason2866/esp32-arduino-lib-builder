
# Tasmota ESP32 Arduino Lib Builder [![ESP32 builder](https://github.com/Jason2866/esp32-arduino-lib-builder/actions/workflows/push.yml/badge.svg)](https://github.com/Jason2866/esp32-arduino-lib-builder/actions/workflows/push.yml)

This repository contains the scripts that produce the libraries included with Tasmota esp32-arduino.

### Build on Ubuntu
```bash
sudo apt-get install git wget curl libssl-dev libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-click python-cryptography python-future python-pyparsing python-pyelftools cmake ninja-build ccache
sudo pip install --upgrade pip
git clone https://github.com/Jason2866/esp32-arduino-lib-builder
cd esp32-arduino-lib-builder
./build.sh
```
### Development builds
Look in release and download a version. The day of build is using the commits of this day of IDF / Arduino.

### Stable Release
are based on Arduino Core 2.0.3 and can be used with Platformio for the ESP32, ESP32C3, ESP32S2 and ESP32S3
```                  
[platformio]
platform = https://github.com/tasmota/platform-espressif32/releases/download/v.2.0.3/platform-espressif32-v.2.0.3.zip
framework = arduino, espidf
```
and for the ESP32solo1 with
```
[platformio]
platform = https://github.com/tasmota/platform-espressif32/releases/download/v.2.0.3/platform-espressif32-solo1-v.2.0.3.zip
framework = arduino, espidf
```
The frameworks are here [https://github.com/tasmota/arduino-esp32/releases](https://github.com/tasmota/arduino-esp32/releases)
