import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bat_mx7800_scandevice_platform_interface.dart';

/// An implementation of [BatMx7800ScandevicePlatform] that uses method channels.
class MethodChannelBatMx7800Scandevice extends BatMx7800ScandevicePlatform {
  /// The method channel used to interact with the native platform.

  //final methodChannel = const MethodChannel('bat_mx7800_scandevice');
  final _eventChannel = const EventChannel('scandevice.events');
  final _methodChannel = const MethodChannel('scandevice.methods');

  late bool _beep;
  late bool _vibrate;

  @override
  bool connected = false;

  @override
  bool get beep => _beep;

  @override
  bool get vibrate => _vibrate;

  @override
  final List<Listener> listeners = <Listener>[];

  @override
  set beep(bool v) => invk((_beep = v) ? 'beepOn' : 'beepOff');

  @override
  set vibrate(bool v) => invk((_vibrate = v) ? 'vibrateOn' : 'vibrateOff');

  @override
  void open() => invk('open');

  @override
  void scan() => invk('scan');

  @override
  void setBroadcastOutputMode() => invk('setBroadcastOutScanMode');

  @override
  void close() => invk('close');

  @override
  void reset() => invk('reset');

  @override
  Future init() async {
    try {
      _eventChannel
          .receiveBroadcastStream()
          .forEach((v) => listeners.forEach((listener) => listener(v)));
      connected = true;
    } catch (e) {
      debugPrint('SCANDEVICE CONNECTION ERROR: $e');
      connected = false;
    }

    open();
    setBroadcastOutputMode();

    _beep = await invk<bool>('beep') ?? false;
    _vibrate = await invk<bool>('vibrate') ?? false;
  }

  Future<T?> invk<T>(String method) {
    try {
      return _methodChannel.invokeMethod<T>(method);
    } catch (e) {
      debugPrint('SCANDEVICE INVOKE ERROR: $e');
      return Future.value();
    }
  }
}

typedef void Listener(dynamic message);
