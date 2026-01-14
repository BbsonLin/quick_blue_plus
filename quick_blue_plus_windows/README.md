# quick_blue_plus_windows

Windows implementation of the [quick_blue_plus](../quick_blue_plus) plugin.

## Implementation

This package provides Windows platform support for the quick_blue_plus plugin using:

- **C++/WinRT**: Windows Runtime C++ library
- **Windows Bluetooth LE APIs**: Native Windows 10+ Bluetooth stack
- **Flutter Platform Channels**: Method, Event, and Message channels

## Requirements

### Development Requirements

- Windows 10 version 1809 (October 2018 Update) or later
- Visual Studio 2022 (or 2019)
  - Desktop development with C++ workload
  - Windows 10 SDK (10.0.17763.0 or later)
- CMake 3.22 or higher
- NuGet package manager
- Flutter SDK 3.24.0 or higher

### Runtime Requirements

- Windows 10 version 1809 or later
- Bluetooth 4.0 or higher adapter

## Technical Details

### Native Components

- **C++ Plugin Class**: `QuickBluePlusWindowsPlugin`
- **Registration Function**: `QuickBluePlusWindowsPluginRegisterWithRegistrar`

### Platform Channels

- **Method Channel**: `quick_blue_plus/method`
- **Event Channel**: `quick_blue_plus/event.scanResult`
- **Message Channel**: `quick_blue_plus/message.connector`

### Windows APIs Used

- `Windows.Devices.Bluetooth`: Core Bluetooth LE functionality
- `Windows.Devices.Bluetooth.Advertisement`: Device scanning
- `Windows.Devices.Bluetooth.GenericAttributeProfile`: GATT operations
- `Windows.Devices.Radios`: Bluetooth adapter state

### C++/WinRT NuGet Package

This plugin uses Microsoft.Windows.CppWinRT version 2.0.201102.2.

## Building

The plugin is built automatically as part of the Flutter Windows build process:

```bash
flutter build windows
```

### CMake Configuration

The plugin requires:
- CMake 3.22+
- C++17 or later
- NuGet for package management

## Features

- Bluetooth adapter state checking
- BLE device scanning with advertisement data
- Device connection/disconnection
- GATT service and characteristic discovery
- Characteristic read/write operations
- Notification/indication subscriptions
- MTU negotiation

## Known Limitations

### Pairing

Windows may require device pairing for certain operations depending on:
- Windows version
- Bluetooth adapter driver
- Device security requirements

### Concurrent Connections

The number of simultaneous connections depends on:
- Bluetooth adapter capabilities
- Windows version
- System resources

Typically supports 5-7 concurrent connections.

## Troubleshooting

See [Windows platform documentation](../docs/windows.md) for detailed troubleshooting information.

## License

BSD 3-Clause License - see [LICENSE](LICENSE) file for details.
