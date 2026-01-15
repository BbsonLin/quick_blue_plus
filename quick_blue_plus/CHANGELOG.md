# Changelog

## 1.0.0 - 2026-01-15

### Initial Release

- Migrated from `quick_blue` to `quick_blue_plus`
- Updated to Flutter 3.24+ and Dart 3.5+
- Federated plugin architecture

### Features

- Bluetooth adapter state checking
- BLE device scanning with advertisement data
- Device connection/disconnection management
- GATT service and characteristic discovery
- Characteristic read/write operations
- Notification and indication subscriptions
- MTU negotiation support
- Multiple concurrent device connections

### Platform Support

- Windows ✅ (Available)
- Android 🚧 (Planned)
- iOS 🚧 (Planned)
- macOS 🚧 (Planned)
- Linux 🚧 (Planned)

### Changes from quick_blue

**API Changes:**
- Package: `quick_blue` → `quick_blue_plus`
- Main class: `QuickBlue` → `QuickBluePlus`
- All method signatures remain compatible

**Architecture:**
- Implemented federated plugin structure
- Separated platform interface from implementations
- Platform-specific packages for each supported OS

**Windows Implementation:**
- Based on C++/WinRT and Windows 10 Bluetooth LE APIs
- Requires Windows 10 version 1809 or later
- Updated CMake minimum version to 3.22

### Breaking Changes

None - API remains fully compatible with quick_blue, only class and package names have changed.

### Migration Guide

1. Update imports:
   ```dart
   // Old
   import 'package:quick_blue/quick_blue.dart';

   // New
   import 'package:quick_blue_plus/quick_blue_plus.dart';
   ```

2. Rename class usage:
   ```dart
   // Old
   QuickBlue.startScan();

   // New
   QuickBluePlus.startScan();
   ```

All method names and signatures remain unchanged.
