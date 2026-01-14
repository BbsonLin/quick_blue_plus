# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Project Initialization
- Initial project structure created
- Migration plan documented
- Stage 0 completed: Project scaffolding

## [1.0.0] - TBD

### Added
- Initial release
- Windows platform support
- Basic BLE operations:
  - Scan for devices
  - Connect/disconnect
  - Discover services and characteristics
  - Read characteristic values
  - Write characteristic values (with/without response)
  - Subscribe to notifications
  - Request MTU

### Changed
- Migrated from `quick_blue` to `quick_blue_plus`
- Updated to Flutter 3.24+
- Updated to Dart 3.5+
- Modernized C++/WinRT implementation
- Updated CMake configuration

### Technical Details
- Implemented federated plugin architecture
- Platform interface package for cross-platform abstraction
- Windows implementation using C++/WinRT
- Support for Windows 10 version 1809+

---

## Migration from quick_blue

This project is a fork and modernization of [quick_blue](https://github.com/woodemi/quick_blue).

Key differences:
- Updated for modern Flutter/Dart versions
- Improved Windows implementation
- Enhanced error handling
- Better documentation
- Active maintenance

[Unreleased]: https://github.com/yourusername/quick_blue_plus/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/yourusername/quick_blue_plus/releases/tag/v1.0.0
