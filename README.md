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


### Using the User Interface

You can more easily build the libraries using the user interface found in the `tools/config_editor/` folder.
It is a Python script that allows you to select and edit the options for the libraries you want to build.
The script has mouse support and can also be pre-configured using the same command line arguments as the `build.sh` script.
For more information and troubleshooting, please refer to the [UI README](tools/config_editor/README.md).

To use it, follow these steps:

1. Make sure you have the required dependencies installed:
  - Python 3.9 or later
  - The [Textual](https://github.com/textualize/textual/) library
  - All the dependencies listed in the previous section

2. Execute the script `tools/config_editor/app.py` from any folder. It will automatically detect the path to the root of the repository.

3. Configure the compilation and ESP-IDF options as desired.

4. Click on the "Compile Static Libraries" button to start the compilation process.

5. The script will show the compilation output in a new screen. Note that the compilation process can take many hours, depending on the number of libraries selected and the options chosen.

6. If the compilation is successful you can find the Platformio framework in the `dist` folder alongside this repository.


### Documentation

For more information about how to use the Library builder, please refer to this [Documentation page](https://docs.espressif.com/projects/arduino-esp32/en/latest/lib_builder.html?highlight=lib%20builder)

### Development builds
Look in release and download a version. There is the Info of the used commits of IDF / Arduino.
