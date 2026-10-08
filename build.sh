#!/usr/bin/env bash
set -euo pipefail

cmake -S amnesia/src -B build \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
      -DCMAKE_CXX_FLAGS="-std=gnu++14 -fpermissive -w" \
      -DCMAKE_C_FLAGS="-w" \
      -DCMAKE_EXE_LINKER_FLAGS="-no-pie" \
      -Wno-deprecated

cmake --build build -j"$(nproc)"
