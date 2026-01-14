# Changelog

## 1.0.0 - 2026-01-15

### Initial Release

- Migrated from `quick_blue_windows` to `quick_blue_plus_windows`
- Updated to Flutter 3.24+ and Dart 3.5+
- Updated CMake minimum version to 3.22

### Changes from quick_blue_windows

**Class Renaming:**
- `QuickBlueWindowsPlugin` → `QuickBluePlusWindowsPlugin`
- `QuickBlueWindowsPluginRegisterWithRegistrar` → `QuickBluePlusWindowsPluginRegisterWithRegistrar`

**Channel Updates:**
- Method: `quick_blue/method` → `quick_blue_plus/method`
- Event: `quick_blue/event.scanResult` → `quick_blue_plus/event.scanResult`
- Message: `quick_blue/message.connector` → `quick_blue_plus/message.connector`

**Build Configuration:**
- Updated CMake minimum version from 3.15 to 3.22
- Project name: `quick_blue_windows` → `quick_blue_plus_windows`
- Plugin name: `quick_blue_windows_plugin` → `quick_blue_plus_windows_plugin`
- Bundled libraries variable: `quick_blue_windows_bundled_libraries` → `quick_blue_plus_windows_bundled_libraries`

**Header Files:**
- Directory: `include/quick_blue_windows/` → `include/quick_blue_plus_windows/`
- Header guards: `FLUTTER_PLUGIN_QUICK_BLUE_WINDOWS_PLUGIN_H_` → `FLUTTER_PLUGIN_QUICK_BLUE_PLUS_WINDOWS_PLUGIN_H_`
- Include path: `"include/quick_blue_windows/quick_blue_windows_plugin.h"` → `"include/quick_blue_plus_windows/quick_blue_plus_windows_plugin.h"`

### Features

- Bluetooth availability checking
- BLE device scanning with RSSI and manufacturer data
- Device connection/disconnection with state change callbacks
- GATT service and characteristic discovery
- Characteristic read operations
- Characteristic write operations (with/without response)
- Notification and indication subscriptions
- MTU request support
- Support for multiple concurrent device connections

### Technical Details

- C++/WinRT based implementation
- Uses Windows 10 Bluetooth LE APIs
- Requires Windows 10 version 1809 or later
- Supports Flutter 3.24.0+
- CMake build system
- NuGet package: Microsoft.Windows.CppWinRT 2.0.201102.2
