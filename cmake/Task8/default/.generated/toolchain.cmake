# This file configures the compiler to use with CMake.

set(CMAKE_C_COMPILER_WORKS YES CACHE BOOL "Tell CMake that the compiler works, but cannot be run during the configuration stage")
set(MP_CC "/opt/microchip/xc32/v4.60/bin/xc32-gcc" CACHE PATH "Legacy variable from MPLAB X pointing to the compiler")
set(MP_CC_DIR "/opt/microchip/xc32/v4.60/bin" CACHE PATH "Legacy variable from MPLAB X pointing to the compiler base directory")
set(CMAKE_C_COMPILER "/opt/microchip/xc32/v4.60/bin/xc32-gcc" CACHE FILEPATH "Path to the compiler binary")

set(CMAKE_CXX_COMPILER_WORKS YES CACHE BOOL "Tell CMake that the compiler works, but cannot be run during the configuration stage")
set(MP_CPPC "/opt/microchip/xc32/v4.60/bin/xc32-g++" CACHE PATH "Legacy variable from MPLAB X pointing to the c++ compiler")
set(MP_CPPC_DIR "/opt/microchip/xc32/v4.60/bin" CACHE PATH "Legacy variable from MPLAB X pointing to the c++ compiler base directory")
set(CMAKE_CXX_COMPILER "/opt/microchip/xc32/v4.60/bin/xc32-g++" CACHE FILEPATH "Path to the compiler binary.")
# Legacy variable from MPLAB X pointing to the compiler base directory.
set(MP_CPPC_DIR ${CMAKE_CXX_COMPILER})

set(CMAKE_ASM_COMPILER_WORKS YES CACHE BOOL "Tell CMake that the assembler works, but cannot be run during the configuration stage")
set(MP_AS "/opt/microchip/xc32/v4.60/bin/xc32-gcc" CACHE PATH "Legacy variable from MPLAB X pointing to the assembler")
set(MP_AS_DIR "/opt/microchip/xc32/v4.60/bin" CACHE PATH "Legacy variable from MPLAB X pointing to the assembler base directory")
set(CMAKE_ASM_COMPILER "/opt/microchip/xc32/v4.60/bin/xc32-gcc" CACHE FILEPATH "Path to the compiler binary.")

# Legacy variable from MPLAB X pointing to the assembler binary.
set(MP_AS ${CMAKE_ASM_COMPILER})

set(MP_LD "/opt/microchip/xc32/v4.60/bin/xc32-ld" CACHE FILEPATH "Legacy variable from MPLAB X pointing to the linker binary.")
set(MP_LD_DIR "/opt/microchip/xc32/v4.60/bin" CACHE PATH "Legacy variable from MPLAB X pointing to the linker base directory")

set(MP_AR "/opt/microchip/xc32/v4.60/bin/xc32-ar" CACHE FILEPATH "Legacy variable from MPLAB X pointing to the archiver binary.")
set(MP_AR_DIR "/opt/microchip/xc32/v4.60/bin" CACHE PATH "Legacy variable from MPLAB X pointing to the archiver base directory")

set(CMAKE_AR "/opt/microchip/xc32/v4.60/bin/xc32-ar" CACHE FILEPATH "Path to the archiver binary.")

set(OBJCOPY "/opt/microchip/xc32/v4.60/bin/xc32-objcopy" CACHE FILEPATH "Path to objcopy executable")
set(OBJDUMP "/opt/microchip/xc32/v4.60/bin/xc32-objdump" CACHE FILEPATH "Path to objdump executable")

set(MP_BIN2HEX "/opt/microchip/xc32/v4.60/bin/xc32-bin2hex" CACHE FILEPATH "Legacy variable from MPLAB X pointing to the bin2hex binary.")

# Extend the object path max if the OS is capable and it looks like the toolchain supports it
# See https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation
if(WIN32 AND NOT COMPILER_IS_LONG_PATH_AWARE)
    cmake_host_system_information(
        RESULT LONG_PATHS_ENABLED
        QUERY WINDOWS_REGISTRY "HKEY_LOCAL_MACHINE/SYSTEM/CurrentControlSet/Control/FileSystem"
        VALUE "LongPathsEnabled")
    if(${LONG_PATHS_ENABLED} STREQUAL "1")
        set(CMAKE_C_COMPILER_EXE_MANIFEST_FILE "${CMAKE_C_COMPILER}.manifest")
        if(EXISTS "${CMAKE_C_COMPILER_EXE_MANIFEST_FILE}")
            file( READ "${CMAKE_C_COMPILER_EXE_MANIFEST_FILE}" CMAKE_C_COMPILER_EXE_MANIFEST)
            if(${CMAKE_C_COMPILER_EXE_MANIFEST} MATCHES ".*longPathAware>\\s*true</.*")
                message(STATUS "Windows is configured with LongPathsEnabled, and the compiler has a .manifest with longPathAware=true")
                set(CMAKE_OBJECT_PATH_MAX 32767)
            endif()
        else()
            message(STATUS "Windows is configured with LongPathsEnabled, however the compiler is not")
        endif()
    else()
        message(STATUS "Windows is not configured with LongPathsEnabled, see https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation")
    endif()
endif()

# Do not detect ABI for C, see https://gitlab.kitware.com/cmake/cmake/-/issues/25936
set(CMAKE_C_ABI_COMPILED YES)
# Do not detect ABI for CXX, see https://gitlab.kitware.com/cmake/cmake/-/issues/25936
set(CMAKE_CXX_ABI_COMPILED YES)
# Do not detect ABI for ASM, see https://gitlab.kitware.com/cmake/cmake/-/issues/25936
set(CMAKE_ASM_ABI_COMPILED YES)

# For makefiles, change the search order of make executable so we do not pick up gmake
if("${CMAKE_GENERATOR}" STREQUAL "Unix Makefiles")
    find_program(CMAKE_MAKE_PROGRAM
        NAMES make
        DOC "Find a suitable make, avoid gmake")
endif()

