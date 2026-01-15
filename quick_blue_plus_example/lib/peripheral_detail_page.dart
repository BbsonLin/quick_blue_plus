import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quick_blue_plus/quick_blue_plus.dart';

String gssUuid(String code) => '0000$code-0000-1000-8000-00805f9b34fb';

final gssServBattery = gssUuid('180f');
final gssCharBatteryLevel = gssUuid('2a19');

const woodemiSuffix = 'ba5e-f4ee-5ca1-eb1e5e4b1ce0';

const woodemiServCommand = '57444d01-$woodemiSuffix';
const woodemiCharCommandRequest = '57444e02-$woodemiSuffix';
const woodemiCharCommandResponse = woodemiCharCommandRequest;

const woodemiMtuWuart = 247;

class PeripheralDetailPage extends StatefulWidget {
  final String deviceId;
  final String deviceName;

  const PeripheralDetailPage(this.deviceId, this.deviceName, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PeripheralDetailPageState();
  }
}

class _PeripheralDetailPageState extends State<PeripheralDetailPage> {
  BlueConnectionState _connectionState = BlueConnectionState.disconnected;
  final List<String> _logs = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    QuickBluePlus.setConnectionHandler(_handleConnectionChange);
    QuickBluePlus.setServiceHandler(_handleServiceDiscovery);
    QuickBluePlus.setValueHandler(_handleValueChange);
  }

  @override
  void dispose() {
    super.dispose();
    QuickBluePlus.setValueHandler(null);
    QuickBluePlus.setServiceHandler(null);
    QuickBluePlus.setConnectionHandler(null);
  }

  void _addLog(String message) {
    setState(() {
      _logs.add('[${DateTime.now().toString().substring(11, 23)}] $message');
    });
    // Auto scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleConnectionChange(String deviceId, BlueConnectionState state) {
    if (deviceId == widget.deviceId) {
      setState(() {
        _connectionState = state;
      });
      _addLog('Connection state: ${state.value}');
    }
  }

  void _handleServiceDiscovery(
      String deviceId, String serviceId, List<String> characteristicIds) {
    if (deviceId == widget.deviceId) {
      _addLog('Service: $serviceId');
      _addLog('  Characteristics: ${characteristicIds.length}');
      for (var charId in characteristicIds) {
        _addLog('    - ${charId.substring(0, 8)}...');
      }
    }
  }

  void _handleValueChange(
      String deviceId, String characteristicId, Uint8List value) {
    if (deviceId == widget.deviceId) {
      _addLog('Value changed: ${characteristicId.substring(0, 8)}... = ${_bytesToHex(value)}');
    }
  }

  String _bytesToHex(Uint8List bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
  }

  final serviceUuidController = TextEditingController(text: woodemiServCommand);
  final characteristicUuidController =
      TextEditingController(text: woodemiCharCommandRequest);
  final dataController = TextEditingController(text: '01 0A 00 00 00 01');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deviceName.isEmpty ? 'Device Details' : widget.deviceName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildConnectionCard(),
              const SizedBox(height: 16),
              _buildOperationsCard(),
              const SizedBox(height: 16),
              _buildCharacteristicCard(),
              const SizedBox(height: 16),
              _buildLogCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Connection',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            Text('Device ID: ${widget.deviceId}'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Status: '),
                Chip(
                  label: Text(_connectionState.value.toUpperCase()),
                  backgroundColor: _connectionState == BlueConnectionState.connected
                      ? Colors.green.shade100
                      : Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: _connectionState == BlueConnectionState.connected
                        ? Colors.green.shade900
                        : Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.link),
                    label: const Text('Connect'),
                    onPressed: _connectionState == BlueConnectionState.disconnected
                        ? () {
                            QuickBluePlus.connect(widget.deviceId);
                            _addLog('Connecting...');
                          }
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.link_off),
                    label: const Text('Disconnect'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _connectionState == BlueConnectionState.connected
                        ? () {
                            QuickBluePlus.disconnect(widget.deviceId);
                            _addLog('Disconnecting...');
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationsCard() {
    final isConnected = _connectionState == BlueConnectionState.connected;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.settings, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Operations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text('Discover Services'),
                onPressed: isConnected
                    ? () {
                        QuickBluePlus.discoverServices(widget.deviceId);
                        _addLog('Discovering services...');
                      }
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.battery_std),
                label: const Text('Read Battery Level'),
                onPressed: isConnected
                    ? () async {
                        _addLog('Reading battery level...');
                        await QuickBluePlus.readValue(
                          widget.deviceId,
                          gssServBattery,
                          gssCharBatteryLevel,
                        );
                      }
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.settings_input_antenna),
                label: const Text('Request MTU (247)'),
                onPressed: isConnected
                    ? () async {
                        _addLog('Requesting MTU...');
                        var mtu = await QuickBluePlus.requestMtu(
                            widget.deviceId, woodemiMtuWuart);
                        _addLog('MTU granted: $mtu');
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacteristicCard() {
    final isConnected = _connectionState == BlueConnectionState.connected;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.edit, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Characteristic Operations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            TextField(
              controller: serviceUuidController,
              decoration: const InputDecoration(
                labelText: 'Service UUID',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: characteristicUuidController,
              decoration: const InputDecoration(
                labelText: 'Characteristic UUID',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: dataController,
              decoration: const InputDecoration(
                labelText: 'Data (hex, space separated)',
                border: OutlineInputBorder(),
                isDense: true,
                hintText: '01 0A 00 00 00 01',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.notifications_active),
                    label: const Text('Subscribe'),
                    onPressed: isConnected
                        ? () {
                            QuickBluePlus.setNotifiable(
                              widget.deviceId,
                              serviceUuidController.text,
                              characteristicUuidController.text,
                              BleInputProperty.notification,
                            );
                            _addLog('Subscribed to notifications');
                          }
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text('Write'),
                    onPressed: isConnected
                        ? () {
                            try {
                              final hexValues = dataController.text
                                  .split(' ')
                                  .map((h) => int.parse(h, radix: 16))
                                  .toList();
                              final value = Uint8List.fromList(hexValues);
                              QuickBluePlus.writeValue(
                                widget.deviceId,
                                serviceUuidController.text,
                                characteristicUuidController.text,
                                value,
                                BleOutputProperty.withResponse,
                              );
                              _addLog('Wrote: ${_bytesToHex(value)}');
                            } catch (e) {
                              _addLog('Error: Invalid hex format');
                            }
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.article, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text(
                      'Event Log',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextButton.icon(
                  icon: const Icon(Icons.clear_all, size: 16),
                  label: const Text('Clear'),
                  onPressed: () {
                    setState(() => _logs.clear());
                  },
                ),
              ],
            ),
            const Divider(),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: _logs.isEmpty
                  ? const Center(
                      child: Text(
                        'No events yet',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: _logs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            _logs[index],
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
