import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class BatMx7800Scandevice {
  final _eventChannel = const EventChannel('scandevice.events');
  final _methodChannel = const MethodChannel('scandevice.methods');

  bool _beep = false;
  bool _vibrate = false;

  bool connected = false;
  bool get scanBeep => _beep;
  bool get scanVibrate => _vibrate;

  final List<Listener> listeners = <Listener>[];

  set scanBeep(bool v) => invk((_beep = v) ? 'beepOn' : 'beepOff');
  set scanVibrate(bool v) => invk((_vibrate = v) ? 'vibrateOn' : 'vibrateOff');
  void openScan() => invk('open');
  void scan() => invk('scan');
  void setBroadcastOutputMode() => invk('setBroadcastOutScanMode');
  void closeScan() => invk('close');
  void resetScan() => invk('reset');

  Future<bool> init() async {
    try {
      _eventChannel
          .receiveBroadcastStream()
          // ignore: avoid_function_literals_in_foreach_calls
          .forEach((v) => listeners.forEach((listener) => listener(v)));
      connected = true;
      openScan();
      setBroadcastOutputMode();

      _beep = await invk<bool>('beep') ?? false;
      _vibrate = await invk<bool>('vibrate') ?? false;
    } catch (e) {
      _beep = false;
      _vibrate = false;
      debugPrint('SCANDEVICE CONNECTION ERROR: $e');
      connected = false;
    }

    return connected;
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

typedef Listener = void Function(dynamic message);
