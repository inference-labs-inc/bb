#!/bin/bash
set -e

echo "Building bb v2.0.3 for macOS ARM64..."

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
rm -rf aztec-packages-2.0.3* v2.0.3.tar.gz
curl -L -o v2.0.3.tar.gz https://github.com/AztecProtocol/aztec-packages/archive/refs/tags/v2.0.3.tar.gz
tar -xzf v2.0.3.tar.gz
cd aztec-packages-2.0.3/barretenberg/cpp

# Build
mkdir -p build
cd build

cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=/usr/bin/clang \
    -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
    -DTESTING=OFF \
    -DBENCHMARK=OFF \
    -DFUZZING=OFF \
    -GNinja

ninja bb

./bin/bb --version
mkdir -p ~/.bb
cp ./bin/bb ~/.bb/