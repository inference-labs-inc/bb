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
brew install cmake ninja llvm pkg-config

# Set LLVM paths
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export CC=clang
export CXX=clang++

# Download and extract Aztec packages
rm -rf aztec-packages-2.0.3* v2.0.3.tar.gz
wget https://github.com/AztecProtocol/aztec-packages/archive/refs/tags/v2.0.3.tar.gz
tar -xzf v2.0.3.tar.gz
cd aztec-packages-2.0.3/barretenberg/cpp

# Build
mkdir -p build
cd build

cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DTESTING=OFF \
    -DBENCHMARK=OFF \
    -DFUZZING=OFF \
    -GNinja

ninja bb

./bin/bb --version
mkdir -p ~/.bb
cp ./bin/bb ~/.bb/