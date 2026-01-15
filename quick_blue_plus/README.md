# quick_blue_plus

A cross-platform Bluetooth Low Energy (BLE) plugin for Flutter, modernized for Flutter 3.24+ and Dart 3.5+.

## Features

- Bluetooth adapter state checking
- BLE device scanning with advertisement data
- Device connection/disconnection management
- GATT service and characteristic discovery
- Characteristic read/write operations
- Notification and indication subscriptions
- MTU negotiation support
- Multiple concurrent device connections

## Platform Support

| Platform | Status |
|----------|--------|
| Android  | 🚧 Planned |
| iOS      | 🚧 Planned |
| macOS    | 🚧 Planned |
| Windows  | ✅ Available |
| Linux    | 🚧 Planned |

## Requirements

### Windows
- Windows 10 version 1809 (October 2018 Update) or later
- Bluetooth 4.0 or higher adapter
- Flutter 3.24.0+
- Dart 3.5.0+

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  quick_blue_plus:
    path: ../quick_blue_plus
```

## Usage

### Initialize Bluetooth

```dart
import 'package:quick_blue_plus/quick_blue_plus.dart';

// Check if Bluetooth is available
bool isAvailable = await QuickBluePlus.isBluetoothAvailable();
```

### Scan for Devices

```dart
// Start scanning
QuickBluePlus.startScan();

// Listen to scan results
QuickBluePlus.scanResultStream.listen((result) {
  print('Device found: ${result.name}');
  print('Device ID: ${result.deviceId}');
  print('RSSI: ${result.rssi}');
});

// Stop scanning
QuickBluePlus.stopScan();
```

### Connect to Device

```dart
// Set connection state handler
QuickBluePlus.setConnectionHandler((deviceId, state) {
  print('Device $deviceId connection state: $state');
});

// Connect
QuickBluePlus.connect(deviceId);

// Disconnect
QuickBluePlus.disconnect(deviceId);
```

### Discover Services

```dart
// Set service discovery handler
QuickBluePlus.setServiceHandler((deviceId, services) {
  print('Services discovered: $services');
});

// Discover services
QuickBluePlus.discoverServices(deviceId);
```

### Read/Write Characteristics

```dart
// Set value change handler for notifications
QuickBluePlus.setValueHandler((deviceId, characteristicId, value) {
  print('Value changed: $value');
});

// Read characteristic
await QuickBluePlus.readValue(deviceId, serviceId, characteristicId);

// Write characteristic
await QuickBluePlus.writeValue(
  deviceId,
  serviceId,
  characteristicId,
  value,
  BleOutputProperty.withResponse,
);

// Enable notifications
await QuickBluePlus.setNotifiable(
  deviceId,
  serviceId,
  characteristicId,
  BleInputProperty.notification,
);
```

### Request MTU

```dart
int mtu = await QuickBluePlus.requestMtu(deviceId, 512);
print('MTU: $mtu');
```

## Example

See the [example](../quick_blue_plus_example) directory for a complete working example.

## Migration from quick_blue

If you're migrating from the original `quick_blue` package:

1. Update all imports:
   - `package:quick_blue/quick_blue.dart` → `package:quick_blue_plus/quick_blue_plus.dart`

2. Rename class:
   - `QuickBlue` → `QuickBluePlus`

3. All method names and signatures remain the same.

## Architecture

This plugin uses a federated architecture:

- **quick_blue_plus** - Main package providing the public API
- **quick_blue_plus_platform_interface** - Platform interface defining the contract
- **quick_blue_plus_windows** - Windows platform implementation using C++/WinRT
- **quick_blue_plus_android** - (Planned) Android implementation
- **quick_blue_plus_ios** - (Planned) iOS implementation
- **quick_blue_plus_macos** - (Planned) macOS implementation
- **quick_blue_plus_linux** - (Planned) Linux implementation

## Known Limitations

### Windows

- May require device pairing for certain operations
- Concurrent connection limit depends on adapter capabilities (typically 5-7 devices)

See [docs/windows.md](../docs/windows.md) for detailed Windows-specific information.

## Troubleshooting

### Windows

1. **Bluetooth not available**
   - Ensure Bluetooth is enabled in Windows Settings
   - Check Device Manager for Bluetooth adapter driver issues

2. **Cannot connect to device**
   - Some devices may require pairing through Windows Settings first
   - Check if device is already connected to another application

3. **Build errors**
   - Ensure Visual Studio 2022 (or 2019) is installed with Desktop C++ workload
   - Verify Windows 10 SDK is installed

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

BSD 3-Clause License - see [LICENSE](LICENSE) file for details.

## Credits

This project is a modernized fork of [quick_blue](https://github.com/woodemi/quick_blue), updated to support Flutter 3.24+ and Dart 3.5+.
