import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bat_mx7800_scandevice_method_channel.dart';

abstract class BatMx7800ScandevicePlatform extends PlatformInterface {
  /// Constructs a BatMx7800ScandevicePlatform.
  BatMx7800ScandevicePlatform() : super(token: _token);

  static final Object _token = Object();

  static BatMx7800ScandevicePlatform _instance =
      MethodChannelBatMx7800Scandevice();

  /// The default instance of [BatMx7800ScandevicePlatform] to use.
  ///
  /// Defaults to [MethodChannelBatMx7800Scandevice].
  static BatMx7800ScandevicePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BatMx7800ScandevicePlatform] when
  /// they register themselves.
  static set instance(BatMx7800ScandevicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future init();
  void open();
  void scan();
  void setBroadcastOutputMode();
  void close();
  void reset();
  set beep(bool v);
  set vibrate(bool v);

  bool get connected => instance.connected;
  bool get beep => instance.beep;
  bool get vibrate => instance.vibrate;

  final List<Listener> listeners = instance.listeners;
}
