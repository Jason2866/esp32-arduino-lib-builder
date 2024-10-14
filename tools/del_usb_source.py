import argparse
import os
import sys
import shutil
from os.path import join


def main(dir):

    s2_sdkconfig_path = os.path.join(dir, "esp32s2", "bin", "sdkconfig")
    if os.path.exists(s2_sdkconfig_path) == False:
      print("*** sdkconfig file for esp32s2 not found, no changes done ***")
      return

    with open(s2_sdkconfig_path) as src:
        line = src.readline()
        if line.startswith("# CONFIG_TINYUSB_ENABLED is not set"):
            print("*** removing USB Source code, since TinyUSB is disabled ***")
            rm -rf arduino-esp32/cores/esp32/esp32-hal-tinyusb.c
            rm -rf arduino-esp32/cores/esp32/esp32-hal-tinyusb.h
            rm -rf arduino-esp32/cores/esp32/USB.cpp
            rm -rf arduino-esp32/cores/esp32/USB.h
            rm -rf arduino-esp32/cores/esp32/USBCDC.cpp
            rm -rf arduino-esp32/cores/esp32/USBCDC.h
            rm -rf arduino-esp32/cores/esp32/USBMSC.cpp
            rm -rf arduino-esp32/cores/esp32/USBMSC.h
            
            rm -rf arduino-esp32/libraries/USB
    
    return 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-d",
        "--dir",
        dest="dir",
        required=True,
        help="Directory folder where the esp32-s2 'sdkonfig' file is located",
    )
    args = parser.parse_args()

    sys.exit(main(args.dir))
