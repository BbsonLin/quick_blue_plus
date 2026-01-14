# Changelog

## 1.0.0 - 2026-01-15

### Initial Release

- Migrated from `quick_blue_platform_interface` to `quick_blue_plus_platform_interface`
- Updated to Flutter 3.24+ and Dart 3.5+
- Updated channel names:
  - `quick_blue/method` → `quick_blue_plus/method`
  - `quick_blue/event.scanResult` → `quick_blue_plus/event.scanResult`
  - `quick_blue/message.connector` → `quick_blue_plus/message.connector`
- Renamed classes:
  - `QuickBluePlatform` → `QuickBluePlusPlatform`
  - `MethodChannelQuickBlue` → `MethodChannelQuickBluePlus`
- Updated dependencies:
  - `plugin_platform_interface: ^2.1.8`
  - `logging: ^1.2.0`
- Code cleanup: removed unnecessary imports

### Features

- Abstract platform interface for BLE operations
- Support for device scanning
- Device connection/disconnection
- Service and characteristic discovery
- Characteristic read/write operations
- Notification/indication subscriptions
- MTU request support
- Logger integration
