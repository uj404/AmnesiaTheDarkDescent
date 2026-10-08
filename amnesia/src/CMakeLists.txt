cmake_minimum_required (VERSION 2.8.11)
project(Lux)
# CMake 4.x policy floor compatibility
if(POLICY CMP0000)
    cmake_policy(VERSION 3.5)
endif()

# Pin compiler dialect and disable PIE for legacy non-PIC prebuilt archives
if(CMAKE_COMPILEER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++14 -fpermissive -w")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -w")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -no-pie")
endif()

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR})

OPTION(USERDIR_RESOURCES "Allow using local userdirectory resources" ON)

set(MACOSX_BUNDLE_COPYRIGHT "Copyright © 2010-2013 Frictional Games")

OPTION(IS_APPLE_64 "Apple build in 64 bits" OFF)

if(APPLE)
    if(NOT IS_APPLE_64)
        set(CMAKE_OSX_ARCHITECTURES "i386")
    endif()
endif()

# silence some annoying warnings
add_definitions(
    -Wno-switch
    -Wno-reorder
    -Wno-unused-variable
    -Wno-unused-function
)

add_subdirectory(../../HPL2/core core2)

if(USERDIR_RESOURCES)
    add_definitions(
        -DUSERDIR_RESOURCES
    )
endif()

set(VERSION "1.3.1")

add_subdirectory(game game)

if(APPLE)
    add_subdirectory(launcher-macosx launcher)
else()
    add_subdirectory(launcher launcher)
endif()

add_custom_target(GameRelease
    DEPENDS Amnesia Launcher
)
