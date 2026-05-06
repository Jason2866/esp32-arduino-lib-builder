# The following lines of boilerplate have to be in your project's
# CMakeLists in this exact order for cmake to work correctly
cmake_minimum_required(VERSION 3.5)

include($ENV{IDF_PATH}/tools/cmake/project.cmake)
project(arduino-lib-builder)

idf_build_get_property(elf EXECUTABLE GENERATOR_EXPRESSION)

add_custom_command(
	OUTPUT "idf_libs" 
	COMMAND ${CMAKE_SOURCE_DIR}/tools/copy-libs.sh ${IDF_TARGET} "$ENV{CHIP_VARIANT}" "${CONFIG_LIB_BUILDER_FLASHMODE}" "${CONFIG_SPIRAM_MODE_OCT}" "${CONFIG_IDF_TARGET_ARCH_XTENSA}"
	DEPENDS ${elf}
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} 
	VERBATIM
)
add_custom_target(idf-libs DEPENDS "idf_libs")

add_custom_command(
	OUTPUT "copy_bootloader" 
	COMMAND ${CMAKE_SOURCE_DIR}/tools/copy-bootloader.sh ${IDF_TARGET} "$ENV{CHIP_VARIANT}" "${CONFIG_LIB_BUILDER_FLASHMODE}" "${CONFIG_LIB_BUILDER_FLASHFREQ}"
	DEPENDS bootloader 
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} 
	VERBATIM
)
add_custom_target(copy-bootloader DEPENDS "copy_bootloader")

add_custom_command(
	OUTPUT "mem_variant" 
	COMMAND ${CMAKE_SOURCE_DIR}/tools/copy-mem-variant.sh ${IDF_TARGET} "$ENV{CHIP_VARIANT}" "${CONFIG_LIB_BUILDER_FLASHMODE}" "${CONFIG_SPIRAM_MODE_OCT}"
	DEPENDS ${elf}
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} 
	VERBATIM
)
add_custom_target(mem-variant DEPENDS "mem_variant")

idf_build_set_property(COMPILE_DEFINITIONS "-DESP32_ARDUINO_LIB_BUILDER" APPEND)

# Wrap std::__throw_* functions to abort immediately, eliminating ~3KB of
# exception class overhead. Implementation lives in components/throw_stubs.
# ESP-IDF already compiles with -fno-exceptions, so this code was dead anyway.
# These flags must be on the top-level link so they end up in the elf link
# command (extracted by tools/copy-libs.sh into pioarduino-build.py LINKFLAGS
# and flags/ld_flags for downstream Arduino/PlatformIO sketches).
# Source: https://github.com/esphome/esphome/blob/dev/esphome/components/esp32/throw_stubs.cpp
idf_build_set_property(LINK_OPTIONS "-Wl,--wrap=_ZSt20__throw_length_errorPKc" APPEND)
idf_build_set_property(LINK_OPTIONS "-Wl,--wrap=_ZSt19__throw_logic_errorPKc" APPEND)
idf_build_set_property(LINK_OPTIONS "-Wl,--wrap=_ZSt20__throw_out_of_rangePKc" APPEND)
idf_build_set_property(LINK_OPTIONS "-Wl,--wrap=_ZSt24__throw_out_of_range_fmtPKcz" APPEND)
idf_build_set_property(LINK_OPTIONS "-Wl,--wrap=_ZSt17__throw_bad_allocv" APPEND)
idf_build_set_property(LINK_OPTIONS "-Wl,--wrap=_ZSt25__throw_bad_function_callv" APPEND)
# Keep at least one __wrap_* symbol referenced so the object is pulled from
# the static archive during the user sketch link.
idf_build_set_property(LINK_OPTIONS "-u__wrap__ZSt17__throw_bad_allocv" APPEND)
