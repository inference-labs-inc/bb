#!/bin/bash
set -e

BB_VERSION="${BB_VERSION:-v3.0.0-nightly.20251104}"
echo "Building bb $BB_VERSION for macOS ARM64..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install dependencies
echo "Installing dependencies via Homebrew..."
brew install cmake ninja pkg-config

# Use system clang (which properly links with system libc++)
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

# Download and extract Aztec packages
rm -rf aztec-packages-* *.tar.gz
curl -L -o "$BB_VERSION.tar.gz" "https://github.com/AztecProtocol/aztec-packages/archive/refs/tags/$BB_VERSION.tar.gz"
tar -xzf "$BB_VERSION.tar.gz"
cd aztec-packages-*/barretenberg/cpp

# Build
mkdir -p build
cd build

cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=/usr/bin/clang \
    -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
    -DDISABLE_ASM=ON \
    -DDISABLE_ADX=ON \
    -DMULTITHREADING=ON \
    -DOMP_MULTITHREADING=OFF \
    -DTESTING=OFF \
    -DBENCHMARK=OFF \
    -DFUZZING=OFF \
    -GNinja

ninja bb

./bin/bb --version
mkdir -p ~/.bb
cp ./bin/bb ~/.bb/