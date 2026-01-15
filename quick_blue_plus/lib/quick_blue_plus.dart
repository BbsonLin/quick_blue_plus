import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:quick_blue_plus_platform_interface/quick_blue_plus_platform_interface.dart';

import 'models.dart';

export 'package:quick_blue_plus_platform_interface/models.dart';

export 'models.dart';

bool _manualDartRegistrationNeeded = true;

QuickBluePlusPlatform get _instance {
  // This is to manually endorse Dart implementations until automatic
  // registration of Dart plugins is implemented. For details see
  // https://github.com/flutter/flutter/issues/52267.
  if (_manualDartRegistrationNeeded) {
    // Only do the initial registration if it hasn't already been overridden
    // with a non-default instance.
    if (Platform.isWindows) {
      QuickBluePlusPlatform.instance = MethodChannelQuickBluePlus();
    }
    // Future platform support will be added here:
    // else if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
    //   QuickBluePlusPlatform.instance = MethodChannelQuickBluePlus();
    // } else if (Platform.isLinux) {
    //   QuickBluePlusPlatform.instance = QuickBluePlusLinux();
    // }
    _manualDartRegistrationNeeded = false;
  }

  return QuickBluePlusPlatform.instance;
}

class QuickBluePlus {
  static QuickBluePlusPlatform _platform = _instance;

  static setInstance(QuickBluePlusPlatform platform) {
    QuickBluePlusPlatform.instance = platform;
    _platform = QuickBluePlusPlatform.instance;
  }

  static void setLogger(QuickLogger logger) => _platform.setLogger(logger);


  static Future<bool> isBluetoothAvailable() =>
      _platform.isBluetoothAvailable();

  static void startScan() => _platform.startScan();

  static void stopScan() => _platform.stopScan();

  static Stream<BlueScanResult> get scanResultStream {
    return _platform.scanResultStream
      .map((item) => BlueScanResult.fromMap(item));
  }

  static void connect(String deviceId) => _platform.connect(deviceId);

  static void disconnect(String deviceId) => _platform.disconnect(deviceId);

  static void setConnectionHandler(OnConnectionChanged? onConnectionChanged) {
    _platform.onConnectionChanged = onConnectionChanged;
  }

  static void discoverServices(String deviceId) => _platform.discoverServices(deviceId);

  static void setServiceHandler(OnServiceDiscovered? onServiceDiscovered) {
    _platform.onServiceDiscovered = onServiceDiscovered;
  }

  static Future<void> setNotifiable(String deviceId, String service, String characteristic, BleInputProperty bleInputProperty) {
    return _platform.setNotifiable(deviceId, service, characteristic, bleInputProperty);
  }

  static void setValueHandler(OnValueChanged? onValueChanged) {
    _platform.onValueChanged = onValueChanged;
  }

  static Future<void> readValue(String deviceId, String service, String characteristic) {
    return _platform.readValue(deviceId, service, characteristic);
  }

  static Future<void> writeValue(String deviceId, String service, String characteristic, Uint8List value, BleOutputProperty bleOutputProperty) {
    return _platform.writeValue(deviceId, service, characteristic, value, bleOutputProperty);
  }

  static Future<int> requestMtu(String deviceId, int expectedMtu) => _platform.requestMtu(deviceId, expectedMtu);
}
