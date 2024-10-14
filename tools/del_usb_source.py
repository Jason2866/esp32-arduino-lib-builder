
import os
import shutil
from os.path import join


def check_entry_s2_sdkconfig():
    s2_sdkconfig_path = join("$PROJECT_DIR", "esp32s2", "bin", "sdkconfig")
    if os.path.exists(s2_sdkconfig_path) == False:
      print("*** sdkconfig file for esp32s2 not found, no changes will be done ***")
      return

    with open(s2_sdkconfig_path) as src:
        line = src.readline()
        if line.startswith("# CONFIG_TINYUSB_ENABLED is not set"):

    return
