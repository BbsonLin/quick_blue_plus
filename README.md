# quick_blue_plus

A cross-platform BluetoothLE plugin for Flutter (Windows first).

This is a migration and modernization of the [quick_blue](https://github.com/woodemi/quick_blue) plugin, updated to support Flutter 3.24+ and Dart 3.5+.

## Features

- ✅ Windows support (Priority)
- ⬜ Android support (Planned)
- ⬜ iOS support (Planned)
- ⬜ macOS support (Planned)
- ⬜ Linux support (Planned)

## Capabilities

- Scan for BLE devices
- Connect/disconnect to BLE devices
- Discover services and characteristics
- Read characteristic values
- Write characteristic values (with/without response)
- Subscribe to characteristic notifications
- Request MTU size

## Project Structure

This is a [federated plugin](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#federated-plugins) with the following structure:

```
quick_blue_plus/
├── quick_blue_plus/                      # Main plugin package
├── quick_blue_plus_platform_interface/   # Platform interface
├── quick_blue_plus_windows/              # Windows implementation
└── quick_blue_plus_example/              # Example application
```

## Getting Started

### Requirements

- Flutter SDK >= 3.24.0
- Dart SDK >= 3.5.0
- For Windows:
  - Visual Studio 2022 with C++ Desktop Development
  - Windows 10 SDK
  - CMake >= 3.22

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  quick_blue_plus: ^1.0.0
```

### Usage

```dart
import 'package:quick_blue_plus/quick_blue_plus.dart';

// Check Bluetooth availability
bool available = await QuickBluePlus.isBluetoothAvailable();

// Start scanning
QuickBluePlus.startScan();

// Listen to scan results
QuickBluePlus.scanResultStream.listen((device) {
  print('Found device: ${device.name}');
});

// Stop scanning
QuickBluePlus.stopScan();

// Connect to device
await QuickBluePlus.connect(deviceId);

// Discover services
await QuickBluePlus.discoverServices(deviceId);

// Read characteristic
await QuickBluePlus.readValue(deviceId, service, characteristic);

// Write characteristic
await QuickBluePlus.writeValue(
  deviceId,
  service,
  characteristic,
  value,
  BleOutputProperty.withResponse,
);

// Subscribe to notifications
await QuickBluePlus.setNotifiable(
  deviceId,
  service,
  characteristic,
  BleInputProperty.notification,
);

// Disconnect
await QuickBluePlus.disconnect(deviceId);
```

## Platform Specific Information

### Windows

- Uses C++/WinRT and Windows Bluetooth LE APIs
- Requires Windows 10 version 1809 or later
- See [docs/windows.md](docs/windows.md) for detailed information

## Migration from quick_blue

If you're migrating from the original `quick_blue` plugin:

1. Update package name in `pubspec.yaml`
2. Update import statements: `quick_blue` → `quick_blue_plus`
3. The API remains largely compatible

See [docs/migration.md](docs/migration.md) for detailed migration guide.

## Development

### Building from source

```bash
# Clone the repository
git clone https://github.com/yourusername/quick_blue_plus.git
cd quick_blue_plus

# Get dependencies for all packages
cd quick_blue_plus_platform_interface && flutter pub get && cd ..
cd quick_blue_plus_windows && flutter pub get && cd ..
cd quick_blue_plus && flutter pub get && cd ..

# Run example
cd quick_blue_plus_example
flutter pub get
flutter run -d windows
```

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

This project is licensed under the BSD 3-Clause License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Original [quick_blue](https://github.com/woodemi/quick_blue) by woodemi
- Inspired by [flutter_blue_plus](https://pub.dev/packages/flutter_blue_plus)

## Support

- Report issues: [GitHub Issues](https://github.com/yourusername/quick_blue_plus/issues)
- Documentation: [docs/](docs/)

---

**Status:** 🚧 Under Development - Windows platform in progress
