import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:quick_blue_plus/quick_blue_plus.dart';

import 'peripheral_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<BlueScanResult>? _subscription;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      QuickBluePlus.setLogger(Logger('quick_blue_plus_example'));
    }
    _subscription = QuickBluePlus.scanResultStream.listen((result) {
      if (!_scanResults.any((r) => r.deviceId == result.deviceId)) {
        setState(() => _scanResults.add(result));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('QuickBluePlus Example'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          children: [
            _buildBluetoothStatus(),
            _buildButtons(),
            const Divider(color: Colors.blue, thickness: 2),
            _buildListView(),
            _buildPermissionWarning(),
          ],
        ),
      ),
    );
  }

  Widget _buildBluetoothStatus() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<bool>(
        future: QuickBluePlus.isBluetoothAvailable(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 12),
                Text('Checking Bluetooth...'),
              ],
            );
          }

          final available = snapshot.data ?? false;
          return Card(
            color: available ? Colors.green.shade50 : Colors.red.shade50,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    available ? Icons.bluetooth : Icons.bluetooth_disabled,
                    color: available ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Bluetooth: ${available ? "Available" : "Unavailable"}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: available ? Colors.green.shade900 : Colors.red.shade900,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('Start Scan'),
              onPressed: () {
                setState(() => _scanResults.clear());
                QuickBluePlus.startScan();
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.stop),
              label: const Text('Stop Scan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                QuickBluePlus.stopScan();
              },
            ),
          ),
        ],
      ),
    );
  }

  final List<BlueScanResult> _scanResults = [];

  Widget _buildListView() {
    return Expanded(
      child: _scanResults.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bluetooth_searching, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No devices found',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap "Start Scan" to search for BLE devices',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final result = _scanResults[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.devices, color: Colors.blue),
                    title: Text(
                      result.name.isEmpty ? 'Unknown Device' : result.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result.deviceId,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'RSSI: ${result.rssi} dBm',
                          style: TextStyle(
                            fontSize: 12,
                            color: _getRssiColor(result.rssi),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PeripheralDetailPage(result.deviceId, result.name),
                        ),
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: _scanResults.length,
            ),
    );
  }

  Color _getRssiColor(int rssi) {
    if (rssi >= -60) return Colors.green;
    if (rssi >= -80) return Colors.orange;
    return Colors.red;
  }

  Widget _buildPermissionWarning() {
    if (Platform.isAndroid) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber.shade700),
        ),
        child: Row(
          children: [
            Icon(Icons.warning, color: Colors.amber.shade900),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'BLUETOOTH_SCAN/ACCESS_FINE_LOCATION permissions needed',
                style: TextStyle(
                  color: Colors.amber.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
