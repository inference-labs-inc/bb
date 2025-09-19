# BB Binaries

Pre-compiled BB (Barretenberg) binaries for multiple Linux distributions and architectures.

## Supported Platforms

| Platform       | Architectures   |
| -------------- | --------------- |
| Ubuntu 22.04   | x86_64          |
| Ubuntu 24.04   | x86_64          |
| macOS          | aarch64 (ARM64) |

## Usage

Binaries are automatically built and released via GitHub Actions. Download the appropriate binary for your platform from the releases page.

## Building

The build process uses GitHub Actions to cross-compile BB for different platforms. See `.github/workflows/release.yml` for build configuration.

### Manual Build

For Linux x86_64 systems:
```bash
./compile_bb.sh
```

For macOS ARM64 systems:
```bash
./compile_bb_macos.sh
```

The scripts will download Aztec packages v2.0.2 and compile BB locally.
