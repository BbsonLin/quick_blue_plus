# quick_blue_plus_platform_interface

Platform interface for the [quick_blue_plus](../quick_blue_plus) plugin.

## Usage

This package defines the interface that platform implementations must implement.

Platform implementations:
- [quick_blue_plus_windows](../quick_blue_plus_windows) - Windows implementation

## For Plugin Developers

To implement a platform-specific implementation of quick_blue_plus, extend `QuickBluePlusPlatform` and implement all abstract methods.

```dart
import 'package:quick_blue_plus_platform_interface/quick_blue_plus_platform_interface.dart';

class QuickBluePlusMyPlatform extends QuickBluePlusPlatform {
  @override
  Future<bool> isBluetoothAvailable() {
    // Implementation
  }

  // Implement other methods...
}
```

## Channel Names

This package defines the following platform channels:

- Method Channel: `quick_blue_plus/method`
- Event Channel: `quick_blue_plus/event.scanResult`
- Message Channel: `quick_blue_plus/message.connector`

## Models

### BlueConnectionState

Connection states for Bluetooth devices:
- `disconnected`
- `connected`

### BleInputProperty

Input properties for characteristic notifications:
- `disabled` - Disable notifications
- `notification` - Enable notifications
- `indication` - Enable indications

### BleOutputProperty

Output properties for characteristic writes:
- `withResponse` - Write with response
- `withoutResponse` - Write without response

## Callbacks

The platform interface provides several callback mechanisms:

- `OnConnectionChanged` - Connection state changes
- `OnServiceDiscovered` - Service discovery results
- `OnValueChanged` - Characteristic value changes

## Requirements

- Flutter SDK >= 3.24.0
- Dart SDK >= 3.5.0
