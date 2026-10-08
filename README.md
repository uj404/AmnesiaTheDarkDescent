Amnesia: The Dark Descent Source Code
=======================

Currently the engine uses fbx sdk 2012 which isn't avalable anymore which means the engine wont compile. If you want to give a shot anyway you can find the sdk here:
https://www.autodesk.com/fbx


Other than that, here is almost everything you need to build Amnesia: The Dark Descent. Included are project files for Visual Studio 2010 and CMake for Linux & macOS. 

Contributing Code
-----------------
We encourage everyone to contribute code to this project, so just sign up for a github account, create a fork and hack away at the codebase.

License Information
-------------------
All code is under the GPL Version 3 license. Read the LICENSE file for terms of use of the license.


---

## Building on Modern Linux (x86_64)

### Prerequisites
Install system build tools and OpenGL runtime packages

```bash
# Arch
sudo pacman -S --needed base-devel cmake perl unzip innoextract mesa glu zlib libx11
```

### Build Instructions
1. Extract and restore bundled libraries.

```bash
./setup_dependencies.sh
```

2. Configure and build:
```bash
cmake -S amnesia/src -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j$(nproc)
```

Binaries will be placed in `build/Amnesia.bin.x86_64` and `build/Launcher.bin.x86_64`.

### Installation
Copy the compiled binaries and runtime libraries into your existing game directory:

```bash
GAME_DIR="/path/to/amnesia/game/files"

cp build/Amnesia.bin.x86_64 "$GAME_DIR/"
cp build/Launcher.bin.x86_64 "$GAME_DIR/"
cp -a HPL2/dependencies/lib/linux/lib64 "$GAME_DIR/"
```

Launch the game directly from within `$GAME_DIR`:

```bash
cd "$GAME_DIR"
./Amnesia.bin.x86_64
```
