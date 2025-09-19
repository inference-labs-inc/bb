# BB Binaries

Pre-compiled BB (Barretenberg) binaries for multiple Linux distributions and architectures.

## Supported Platforms

| Ubuntu Version | Architectures   |
| -------------- | --------------- |
| 22.04          | x86_64, aarch64 |
| 24.04          | x86_64, aarch64 |

## Usage

Binaries are automatically built and released via GitHub Actions. Download the appropriate binary for your platform from the releases page.

## Building

The build process uses GitHub Actions to cross-compile BB for different platforms. See `.github/workflows/release.yml` for build configuration.

### Manual Build

For x86_64 systems, run:

```bash
./compile_bb.sh
```

The script will download Aztec packages and compile BB locally.
