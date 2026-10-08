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
Install system build tools and OpenGL runtime packages:

```bash
# Arch
# Core build dependencies
sudo pacman -S --needed base-devel cmake perl unzip mesa glu zlib libx11

# Optional: Only needed if extracting retail data from a GOG installer
sudo pacman -S --needed innoextract
```

### Build Instructions
1. Extract and restore bundled libraries:

```bash
./setup_dependencies.sh
```

2. Configure and build:

```bash
./build.sh
```

Or manually via CMake:

```bash
cmake -S amnesia/src -B build \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
      -DCMAKE_CXX_FLAGS="-std=gnu++14 -fpermissive -w" \
      -DCMAKE_C_FLAGS="-w" \
      -DCMAKE_EXE_LINKER_FLAGS="-no-pie" \
      -Wno-deprecated
cmake --build build -j$(nproc)
```

Binaries will be placed in `build/Amnesia.bin.x86_64` and `build/Launcher.bin.x86_64`.

### Installation & Game Setup

1. Unpack Game Data:
    If using the GOG installer, extract the data files using `innoextract`:
    ```bash
    mkdir -p ~/Games/Amnesia && cd ~/Games/Amnesia
    innoextract /path/to/setup_amnesia_the_dark_descent_*.exe
    ```
(The game data will be in `~/Games/Amnesia/app/`)

1. Install Engine Binaries & Libraries:
    From your build directory, copy the executables and bundled 64-bit libraries into the game folder.
    ```bash
    GAME_DIR=~/Games/Amnesia/app
    
    cp build/Amnesia.bin.x86_64 build/Launcher.bin.x86_64 "$GAME_DIR/"
    cp -a HPL2/dependencies/lib/linux/lib64 "$GAME_DIR/"
    ```

1. SDL2 Configuration (Required for GOG/Pre-1.3 Data):
    Older retail copies predate SDL2 support. Add the required key mappings to your user directory so the game initializes properly:
    ```bash
    D=~/.frictionalgames/Amnesia/local_resources/config
    mkdir -p "$D"
    sed 's#\tDefaultUserKeys\t\t= "config/default_user_keys.cfg"#&\r\n\tDefaultMainSettingsSDL2 = "config/default_main_settings.cfg"\r\n\tDefaultUserKeysSDL2 = "config/default_user_keys.cfg"#' \
    "$GAME_DIR/config/main_init.cfg" > "$D/main_init.cfg"
    ```

### Launching
Always launch the binary directly from within the game directory so resource paths resolve correctly.

```bash
cd ~/Games/Amnesia/app
./Amnesia.bin.x86_64
```
