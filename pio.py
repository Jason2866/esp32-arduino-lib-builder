{
  "tools": [
    {
      "description": "Toolchain for 32-bit Xtensa based on GCC",
      "export_paths": [
        [
          "xtensa-esp-elf",
          "bin"
        ]
      ],
      "strip_container_dirs": 1,
      "export_vars": {},
      "info_url": "https://github.com/espressif/crosstool-NG",
      "install": "always",
      "license": "GPL-3.0-with-GCC-exception",
      "name": "toolchain-xtensa-esp-elf",
      "supported_targets": [
        "esp32",
        "esp32s2",
        "esp32s3"
      ],
      "version_cmd": [
        "xtensa-esp-elf-gcc",
        "--version"
      ],
      "version_regex": "\\(crosstool-NG\\s+(?:crosstool-ng-)?([0-9a-zA-Z\\.\\-_]+)\\)",
      "versions": [
        {
          "linux-amd64": {
            "sha256": "da31f36d79d4e99f24e55a90a71e65d5694714f16199960bf7885724b706a48c",
            "size": 176559292,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20260121/xtensa-esp-elf-14.2.0_20260121-x86_64-linux-gnu.tar.xz"
          },
          "linux-arm64": {
            "sha256": "80ae10ce3d6c02e8c06213f03cac343c4ef6f0fbd89f28530b918f7a1006f1eb",
            "size": 171504672,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20260121/xtensa-esp-elf-14.2.0_20260121-aarch64-linux-gnu.tar.xz"
          },
          "linux-armel": {
            "sha256": "10d8279f286d205a508b97b5440e7ba402b57e48158c02fa18a4bfe1f183fe42",
            "size": 172620104,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20260121/xtensa-esp-elf-14.2.0_20260121-arm-linux-gnueabi.tar.xz"
          },
          "linux-armhf": {
            "sha256": "f1d6296a1e263aa8de9bbcb6f80ebc609ed3385b2905441786ceb05e96de0606",
            "size": 169985628,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20260121/xtensa-esp-elf-14.2.0_20260121-arm-linux-gnueabihf.tar.xz"
          },
          "linux-i686": {
            "sha256": "c60f2991e3e59c1599fa4f03e9ca172958c23761e403c1015349bdd874cc73dd",
            "size": 188758352,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20260121/xtensa-esp-elf-14.2.0_20260121-i586-linux-gnu.tar.xz"
          },
          "macos": {
            "sha256": "02e5e3421222c9a708b21eca7826acb137668b188cb46fbde46339b26d4b2eeb",
            "size": 177355744,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20260121/xtensa-esp-elf-14.2.0_20260121-x86_64-apple-darwin.tar.xz"
          },
          "macos-arm64": {
            "sha256": "a450db49cea5f191a96345c5b7f0e1a9671a9cf132fecfd9fb1faf6c2a30637e",
            "size": 170666656,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20260121/xtensa-esp-elf-14.2.0_20260121-aarch64-apple-darwin.tar.xz"
          },
          "name": "esp-14.2.0_20260121",
          "status": "recommended",
          "win32": {
            "sha256": "d57eeb3783bce663cca312323ac9b305a22dfab479c642320c62aeefcc536ac0",
            "size": 411000830,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20260121/xtensa-esp-elf-14.2.0_20260121-i686-w64-mingw32.zip"
          },
          "win64": {
            "sha256": "82cbe0353c2e7c96acc8755c854aaa2d93d346c6a378fc692e60b3912c560108",
            "size": 413859845,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20260121/xtensa-esp-elf-14.2.0_20260121-x86_64-w64-mingw32.zip"
          }
        }
      ]
    }
  ],
  "version": 1
}
