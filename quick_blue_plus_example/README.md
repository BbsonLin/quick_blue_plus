# quick_blue_plus_example

Example application demonstrating the use of the quick_blue_plus plugin for Bluetooth Low Energy (BLE) operations on Windows.

## Features

This example app demonstrates all major BLE operations:

### Main Screen
- **Bluetooth Status**: Shows if Bluetooth is available on the device
- **Device Scanning**: Start/stop BLE device scanning
- **Device List**: Displays discovered devices with:
  - Device name (or "Unknown Device")
  - Device ID (MAC address)
  - RSSI (signal strength) with color-coded indicators:
    - Green: Strong signal (≥ -60 dBm)
    - Orange: Medium signal (-60 to -80 dBm)
    - Red: Weak signal (< -80 dBm)

### Device Detail Screen
- **Connection Management**:
  - Connect/disconnect to BLE devices
  - Real-time connection status display

- **Service Operations**:
  - Discover GATT services and characteristics
  - Read battery level (standard GATT service)
  - Request MTU (Maximum Transmission Unit)

- **Characteristic Operations**:
  - Subscribe to notifications/indications
  - Write data to characteristics (hex format)
  - Configurable service and characteristic UUIDs
  - Custom data input in hex format

- **Event Log**:
  - Real-time log of all BLE events
  - Timestamps for each event
  - Auto-scrolling log view
  - Clear log functionality

## Getting Started

### Prerequisites

- Windows 10 version 1809 (October 2018 Update) or later
- Bluetooth 4.0 or higher adapter
- Flutter 3.24.0+
- Visual Studio 2022 (or 2019) with Desktop C++ workload

### Building

```bash
# Navigate to example directory
cd quick_blue_plus_example

# Get dependencies
flutter pub get

# Build for Windows
flutter build windows

# Or run directly
flutter run -d windows
```

### Running the Example

1. **Launch the app**:
   ```bash
   flutter run -d windows
   ```

2. **Check Bluetooth status**:
   - The app will automatically check if Bluetooth is available
   - If unavailable, enable Bluetooth in Windows Settings

3. **Scan for devices**:
   - Tap "Start Scan" to begin scanning for BLE devices
   - Devices will appear in the list as they are discovered
   - Tap "Stop Scan" to end scanning

4. **Connect to a device**:
   - Tap on any device in the list
   - The Device Detail page will open
   - Tap "Connect" to establish connection

5. **Explore services**:
   - Once connected, tap "Discover Services"
   - Services and characteristics will be logged

6. **Read/Write operations**:
   - Use "Read Battery Level" to read standard battery service
   - Configure Service/Characteristic UUIDs for custom operations
   - Enter hex data and tap "Write" to send data
   - Tap "Subscribe" to receive notifications

## UI Screenshots

### Main Screen
- Clean, modern Material Design 3 interface
- Color-coded signal strength indicators
- Empty state with helpful instructions

### Device Detail Screen
- Organized card-based layout
- Connection status chip
- Quick action buttons
- Scrollable event log with timestamps

## Code Structure

```
lib/
├── main.dart                      # Main app and scan screen
└── peripheral_detail_page.dart    # Device detail and operations
```

### Key Components

- **MyApp**: Main stateful widget managing scan results
- **PeripheralDetailPage**: Device connection and GATT operations
- **Event Handlers**: Callbacks for connection, service discovery, and value changes

## Testing

### Test with Real Devices

The app works with any BLE device. For testing, you can use:

1. **Smart watches/fitness trackers**
2. **BLE development boards** (ESP32, nRF52, etc.)
3. **Smart home devices** (lights, sensors)
4. **Mobile phones** in BLE peripheral mode

### Common Test UUIDs

The example includes default UUIDs for testing:

- **Battery Service**: `0000180f-0000-1000-8000-00805f9b34fb`
- **Battery Level**: `00002a19-0000-1000-8000-00805f9b34fb`
- **Custom WOODEMI Service** (example): `57444d01-ba5e-f4ee-5ca1-eb1e5e4b1ce0`

## Troubleshooting

### Bluetooth Not Available

- Ensure Bluetooth is enabled in Windows Settings
- Check Device Manager for Bluetooth adapter driver issues
- Restart the application after enabling Bluetooth

### Cannot Connect to Device

- Some devices require pairing through Windows Settings first
- Ensure device is not already connected to another application
- Try restarting both the device and the application

### No Devices Found

- Ensure devices are powered on and in range
- Check that devices are in BLE advertising mode
- Some devices have limited advertising duration

### Build Errors

- Ensure Visual Studio 2022 with Desktop C++ workload is installed
- Verify Windows 10 SDK is installed (10.0.17763.0 or later)
- Run `flutter doctor -v` to check for missing dependencies

## Platform Support

Currently, this example only supports Windows. Support for other platforms (Android, iOS, macOS, Linux) is planned.

| Platform | Status |
|----------|--------|
| Windows  | ✅ Available |
| Android  | 🚧 Planned |
| iOS      | 🚧 Planned |
| macOS    | 🚧 Planned |
| Linux    | 🚧 Planned |

## License

This example application is part of the quick_blue_plus project and is licensed under the BSD 3-Clause License.

## Related Links

- [quick_blue_plus Package](../quick_blue_plus)
- [Windows Platform Documentation](../docs/windows.md)
- [quick_blue_plus_windows Plugin](../quick_blue_plus_windows)

## Feedback

If you encounter issues or have suggestions for improving this example:

- Open an issue on GitHub
- Submit a pull request with improvements
- Check existing issues for known problems

## Credits

This example is based on the original [quick_blue](https://github.com/woodemi/quick_blue) example, modernized for Flutter 3.24+ and enhanced with improved UI/UX.
