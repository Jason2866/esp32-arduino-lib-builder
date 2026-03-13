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
            "sha256": "b0065b3b28d2b5d3bf4868f2fda6bc95d6081025583d1c17b286884bead0305d",
            "size": 176948400,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/xtensa-esp-elf-14.2.0_20251107-x86_64-linux-gnu.tar.xz"
          },
          "linux-arm64": {
            "sha256": "571f1d3d4aa46f75d86f4c0f5c6c492fac6849de8345dae919875fa087c59591",
            "size": 172565944,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/xtensa-esp-elf-14.2.0_20251107-aarch64-linux-gnu.tar.xz"
          },
          "linux-armel": {
            "sha256": "f8f3acabdea942ad42e8ad8748aaae993dfb6ba6c552d7e701ca42d90d857317",
            "size": 170518776,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/xtensa-esp-elf-14.2.0_20251107-arm-linux-gnueabi.tar.xz"
          },
          "linux-armhf": {
            "sha256": "c028f6902d652092b73655eba3780a120e901a24cff184d0be104a3e44c3d54a",
            "size": 171649224,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/xtensa-esp-elf-14.2.0_20251107-arm-linux-gnueabihf.tar.xz"
          },
          "linux-i686": {
            "sha256": "d86fb12480129b722c2cb7515fbcb6a066083b50a38c33c193f2f17eede70575",
            "size": 180444520,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/xtensa-esp-elf-14.2.0_20251107-i586-linux-gnu.tar.xz"
          },
          "macos": {
            "sha256": "9a0f6f4d83ff39af41f1d2ebbf4683668c95d4a47a3bf5b1fa74eef80f3af1bb",
            "size": 183731136,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/xtensa-esp-elf-14.2.0_20251107-x86_64-apple-darwin.tar.xz"
          },
          "macos-arm64": {
            "sha256": "cffc8213e8e5fea03d12e027868d743ff4d23263e6d45a98b03d18adec6454de",
            "size": 168886320,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/xtensa-esp-elf-14.2.0_20251107-aarch64-apple-darwin.tar.xz"
          },
          "name": "esp-14.2.0_20251107",
          "status": "recommended",
          "win32": {
            "sha256": "70778f0e7dad518f9e6547911bedd6e23c48775313c7ed92f1cb04a86cea2351",
            "size": 391481671,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/xtensa-esp-elf-14.2.0_20251107-i686-w64-mingw32.zip"
          },
          "win64": {
            "sha256": "b0de5062da2f05d1773d1537421134e2a7517bd74a06c3b5763b07f94e38bece",
            "size": 396056136,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/xtensa-esp-elf-14.2.0_20251107-x86_64-w64-mingw32.zip"
          }
        }
      ]
    }
  ],
  "version": 1
}
