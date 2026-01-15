import 'dart:typed_data';

class BlueScanResult {
  String name;
  String deviceId;
  Uint8List? _manufacturerDataHead;
  Uint8List? _manufacturerData;
  int rssi;

  BlueScanResult.fromMap(map)
      : name = map['name'],
        deviceId = map['deviceId'],
        rssi = map['rssi'] {
    _manufacturerDataHead = map['manufacturerDataHead'];
    _manufacturerData = map['manufacturerData'];
  }

  Uint8List get manufacturerDataHead {
    return _manufacturerDataHead ?? Uint8List(0);
  }

  Uint8List get manufacturerData {
    return _manufacturerData ?? Uint8List(0);
  }

  @override
  String toString() {
    return 'BlueScanResult{name: $name, deviceId: $deviceId, manufacturerDataHead: $manufacturerDataHead, rssi: $rssi}';
  }
}
