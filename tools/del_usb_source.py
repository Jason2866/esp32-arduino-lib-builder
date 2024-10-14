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
            print("*** TinyUSB is disabled, removing not needed USB Source code ***")
            os.remove("arduino-esp32/cores/esp32/esp32-hal-tinyusb.c")
            os.remove("arduino-esp32/cores/esp32/esp32-hal-tinyusb.h")
            os.remove("arduino-esp32/cores/esp32/USB.cpp")
            os.remove("arduino-esp32/cores/esp32/USB.h")
            os.remove("arduino-esp32/cores/esp32/USBCDC.cpp")
            os.remove("arduino-esp32/cores/esp32/USBCDC.h")
            os.remove("arduino-esp32/cores/esp32/USBMSC.cpp")
            os.remove("arduino-esp32/cores/esp32/USBMSC.h")
            shutil.rmtree("arduino-esp32/libraries/USB", ignore_errors=True)
        return 0
    return


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
