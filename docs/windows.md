# Windows Platform Support

## Overview

The Windows implementation of `quick_blue_plus` uses C++/WinRT and Windows Bluetooth LE APIs.

## Requirements

### System Requirements
- Windows 10 version 1809 (October 2018 Update) or later
- Bluetooth 4.0 or higher adapter

### Development Requirements
- Visual Studio 2022 (or 2019)
  - Desktop development with C++ workload
  - Windows 10 SDK (10.0.17763.0 or later)
- CMake 3.22 or higher
- NuGet package manager
- Flutter SDK 3.24.0 or higher

## Architecture

### Components

```
quick_blue_plus_windows/
├── lib/
│   └── quick_blue_plus_windows.dart          # Dart platform implementation
└── windows/
    ├── CMakeLists.txt                         # Build configuration
    ├── quick_blue_plus_windows_plugin.cpp     # C++ implementation
    └── include/
        └── quick_blue_plus_windows/
            └── quick_blue_plus_windows_plugin.h
```

### Windows APIs Used

- **Windows.Devices.Bluetooth**: Core Bluetooth LE functionality
- **Windows.Devices.Bluetooth.Advertisement**: Device scanning
- **Windows.Devices.Bluetooth.GenericAttributeProfile**: GATT operations
- **Windows.Devices.Radios**: Bluetooth adapter state

## Communication Channels

### Method Channel
- Name: `quick_blue_plus/method`
- Used for: Synchronous method calls (scan, connect, read, write, etc.)

### Event Channel
- Name: `quick_blue_plus/event.scanResult`
- Used for: Streaming scan results

### Message Channel
- Name: `quick_blue_plus/message.connector`
- Used for: Bidirectional messages (connection state, characteristic values)

## Implementation Details

### Bluetooth Scanning

Uses `BluetoothLEAdvertisementWatcher` to scan for nearby devices.

```cpp
bluetoothLEWatcher = BluetoothLEAdvertisementWatcher();
bluetoothLEWatcher.Received({ this, &Handler::OnReceived });
bluetoothLEWatcher.Start();
```

### Device Connection

Connections are established using `BluetoothLEDevice::FromBluetoothAddressAsync()`.

### GATT Operations

- **Service Discovery**: `GetGattServicesAsync()`
- **Characteristic Discovery**: `GetCharacteristicsAsync()`
- **Read**: `ReadValueAsync()`
- **Write**: `WriteValueAsync()` with `GattWriteOption`
- **Notifications**: `WriteClientCharacteristicConfigurationDescriptorAsync()`

### MTU Configuration

Uses `GattSession::FromDeviceIdAsync()` to get maximum PDU size.

## Known Limitations

### Pairing Requirements

Windows may require device pairing for some operations depending on:
- Windows version
- Bluetooth adapter driver
- Device security requirements

See: [Windows Bluetooth LE Pairing](https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/gatt-client)

### Concurrent Connections

The number of simultaneous connections depends on:
- Bluetooth adapter capabilities
- Windows version
- System resources

Typically supports 5-7 concurrent connections.

## Troubleshooting

### Bluetooth Not Available

**Problem**: `isBluetoothAvailable()` returns false

**Solutions**:
1. Check Bluetooth is enabled in Windows Settings
2. Verify Bluetooth adapter drivers are installed
3. Check Device Manager for adapter issues
4. Restart Bluetooth service:
   ```powershell
   Restart-Service bthserv
   ```

### Connection Failures

**Problem**: Cannot connect to device

**Solutions**:
1. Ensure device is in range and powered on
2. Remove device from Windows paired devices if previously paired
3. Check Windows Privacy settings allow Bluetooth access
4. Try pairing the device in Windows Settings first

### Service Discovery Issues

**Problem**: Services not found after connection

**Solutions**:
1. Ensure device is fully connected (check connection state)
2. Wait a moment after connection before discovering services
3. Check device supports GATT services

### Compilation Errors

**Problem**: Build fails with C++ errors

**Solutions**:
1. Ensure Visual Studio C++ workload is installed
2. Verify Windows SDK version
3. Check CMake version (>= 3.22)
4. Clean build directory:
   ```bash
   flutter clean
   flutter pub get
   flutter build windows
   ```

### NuGet Package Issues

**Problem**: Cannot download Microsoft.Windows.CppWinRT

**Solutions**:
1. Check internet connection
2. Verify NuGet is installed and in PATH
3. Clear NuGet cache:
   ```powershell
   nuget locals all -clear
   ```

## Performance Considerations

### Scanning
- Continuous scanning drains battery on laptops
- Stop scanning when not needed
- Filter scan results on the Dart side if needed

### Notifications
- Subscribe only to needed characteristics
- Unsubscribe when done to free resources

### Memory Management
- C++ side automatically cleans up on disconnect
- Ensure proper disconnect to avoid leaks

## Best Practices

1. **Always check Bluetooth availability** before operations
2. **Handle connection state changes** properly
3. **Implement timeouts** for async operations
4. **Clean up resources** on disconnect
5. **Test on multiple Windows versions** if possible

## Debugging

### Enable Debug Output

The plugin outputs debug information to OutputDebugString. View with:

**Visual Studio**:
- Debug → Windows → Output

**DebugView** (from Sysinternals):
- Download from Microsoft Sysinternals
- Run while testing

### Logging

Add logging to your Flutter app:

```dart
import 'package:logging/logging.dart';

Logger.root.level = Level.ALL;
Logger.root.onRecord.listen((record) {
  print('${record.level.name}: ${record.time}: ${record.message}');
});
```

## References

- [Windows.Devices.Bluetooth Namespace](https://docs.microsoft.com/en-us/uwp/api/windows.devices.bluetooth)
- [Bluetooth LE samples](https://github.com/microsoft/windows-universal-samples/tree/main/Samples/BluetoothLE)
- [C++/WinRT documentation](https://docs.microsoft.com/en-us/windows/uwp/cpp-and-winrt-apis/)
- [Flutter Windows desktop](https://docs.flutter.dev/platform-integration/windows/building)

## Support

For Windows-specific issues, please include:
- Windows version (run `winver`)
- Bluetooth adapter model
- Visual Studio version
- Build output/error messages
- Debug logs if available
