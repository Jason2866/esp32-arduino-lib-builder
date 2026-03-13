{
  "tools": [
    {
      "description": "Toolchain for 32-bit RISC-V based on GCC",
      "export_paths": [
        [
          "riscv32-esp-elf",
          "bin"
        ]
      ],
      "strip_container_dirs": 1,
      "export_vars": {},
      "info_url": "https://github.com/espressif/crosstool-NG",
      "install": "always",
      "license": "GPL-3.0-with-GCC-exception",
      "name": "toolchain-riscv32-esp",
      "supported_targets": [
        "esp32s2",
        "esp32s3",
        "esp32c3",
        "esp32c2",
        "esp32c6",
        "esp32c5",
        "esp32h2",
        "esp32c61",
        "esp32p4"
      ],
      "version_cmd": [
        "riscv32-esp-elf-gcc",
        "--version"
      ],
      "version_regex": "\\(crosstool-NG\\s+(?:crosstool-ng-)?([0-9a-zA-Z\\.\\-_]+)\\)",
      "versions": [
        {
          "linux-amd64": {
            "sha256": "1d3a1b6a064686d9b77c4db7731f82e26c072e312e27969c45fe96410ecb2671",
            "size": 306966476,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/riscv32-esp-elf-14.2.0_20251107-x86_64-linux-gnu.tar.xz"
          },
          "linux-arm64": {
            "sha256": "072a553453691fbd98fe82b6efa9a2fa6beb7d2c90aed4463353bc33378e83bf",
            "size": 299897524,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/riscv32-esp-elf-14.2.0_20251107-aarch64-linux-gnu.tar.xz"
          },
          "linux-armel": {
            "sha256": "2da03aa3497dbff897cc8bb879b2138ba141e8071edec1a2e43b334f98de6424",
            "size": 297707224,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/riscv32-esp-elf-14.2.0_20251107-arm-linux-gnueabi.tar.xz"
          },
          "linux-armhf": {
            "sha256": "6e4bee2ec2c8e922a890b59731746853ea8f14e118fcd6ae5fa58fea5c1aa2eb",
            "size": 297953904,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/riscv32-esp-elf-14.2.0_20251107-arm-linux-gnueabihf.tar.xz"
          },
          "linux-i686": {
            "sha256": "402ed7d177e744916df8afc74c5e5a9cfd40557df07a6a7fc52b00917b15f97b",
            "size": 309687076,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/riscv32-esp-elf-14.2.0_20251107-i586-linux-gnu.tar.xz"
          },
          "macos": {
            "sha256": "d413836fa000f095d041a35950a45f82e2ff669995c8d6a09fa4d05e5c4ed258",
            "size": 309020528,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/riscv32-esp-elf-14.2.0_20251107-x86_64-apple-darwin.tar.xz"
          },
          "macos-arm64": {
            "sha256": "cedfcdaf8f165bd3e11ca4ee46b71d5b561fab93407eb8203812f9c14b1c7714",
            "size": 288327120,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/riscv32-esp-elf-14.2.0_20251107-aarch64-apple-darwin.tar.xz"
          },
          "name": "esp-14.2.0_20251107",
          "status": "recommended",
          "win32": {
            "sha256": "7670128df99adbdcbc99ebbdccda19347daf2fd191aab1eb22c24ae1c4d77226",
            "size": 690936765,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/riscv32-esp-elf-14.2.0_20251107-i686-w64-mingw32.zip"
          },
          "win64": {
            "sha256": "373abecd1cdfd480b09b8659e319e636064f99fec46f635a05c5413e5f009c05",
            "size": 697522467,
            "url": "https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20251107/riscv32-esp-elf-14.2.0_20251107-x86_64-w64-mingw32.zip"
          }
        }
      ]
    }
  ],
  "version": 1
}
