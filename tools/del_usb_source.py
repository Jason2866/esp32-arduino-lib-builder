
import os
import shutil
from os.path import join


def check_entry_s2_sdkconfig():


def main(dir):

    s2_sdkconfig_path = os.path.join(dir, "esp32s2", "bin", "sdkconfig")
    if os.path.exists(s2_sdkconfig_path) == False:
      print("*** sdkconfig file for esp32s2 not found, no changes done ***")
      return

    with open(s2_sdkconfig_path) as src:
        line = src.readline()
        if line.startswith("# CONFIG_TINYUSB_ENABLED is not set"):

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
