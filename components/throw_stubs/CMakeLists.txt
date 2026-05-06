idf_component_register(SRCS "throw_stubs.cpp"
                       INCLUDE_DIRS ""
                       REQUIRES esp_system)

# Wrap std::__throw_* functions to abort immediately, eliminating ~3KB of
# exception class overhead. See throw_stubs.cpp for implementation.
# ESP-IDF already compiles with -fno-exceptions, so this code was dead anyway.
#
# These flags are exported as INTERFACE link options so they appear in the
# arduino-lib-builder elf link command and get extracted by tools/copy-libs.sh
# into the LINKFLAGS of pioarduino-build.py / ld_flags.
target_link_libraries(${COMPONENT_LIB} INTERFACE
    "-Wl,--wrap=_ZSt20__throw_length_errorPKc"
    "-Wl,--wrap=_ZSt19__throw_logic_errorPKc"
    "-Wl,--wrap=_ZSt20__throw_out_of_rangePKc"
    "-Wl,--wrap=_ZSt24__throw_out_of_range_fmtPKcz"
    "-Wl,--wrap=_ZSt17__throw_bad_allocv"
    "-Wl,--wrap=_ZSt25__throw_bad_function_callv"
)

# Force the linker to keep this object so the __wrap_* symbols are available
# during the final link in user sketches.
target_link_libraries(${COMPONENT_LIB} INTERFACE "-u__wrap__ZSt17__throw_bad_allocv")
