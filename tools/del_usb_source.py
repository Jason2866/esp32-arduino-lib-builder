import argparse
import os
import sys
import shutil
from os.path import join


def main(dir_out):
    s2_sdkconfig_path = os.path.join(dir_out, "esp32s2", "bin", "sdkconfig")
    if os.path.exists(s2_sdkconfig_path) == False:
      print("*** sdkconfig file for esp32s2 not found, no changes done ***")
      return

    esp32_dir = os.path.join(dir_out, "arduino-esp32", "cores", "esp32")

    with open(s2_sdkconfig_path) as src:
        line = src.readline()
        if line.startswith("# CONFIG_TINYUSB_ENABLED is not set"):
            print("*** TinyUSB is disabled, removing not needed USB Source code ***")
            os.remove(join(esp32_dir, "esp32-hal-tinyusb.c"))
            os.remove(join(esp32_dir, "esp32-hal-tinyusb.h"))
            os.remove(join(esp32_dir, "USB.cpp"))
            os.remove(join(esp32_dir, "USB.h"))
            os.remove(join(esp32_dir, "USBCDC.cpp"))
            os.remove(join(esp32_dir, "USBCDC.h"))
            os.remove(join(esp32_dir, "USBMSC.cpp"))
            os.remove(join(esp32_dir, "USBMSC.h"))
            shutil.rmtree(join(dir_out, "arduino-esp32", "libraries", "USB"), ignore_errors=True)
    return 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-d",
        "--dir",
        dest="dir_out",
        required=True,
        help="Path to out folder",
    )
    args = parser.parse_args()

    sys.exit(main(args.dir_out))
