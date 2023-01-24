import 'bat_mx7800_scandevice_platform_interface.dart';

class BatMx7800Scandevice {
  final listeners = BatMx7800ScandevicePlatform.instance.listeners;

  Future init() {
    return BatMx7800ScandevicePlatform.instance.init();
  }

  void openScan() {
    return BatMx7800ScandevicePlatform.instance.open();
  }

  void scan() {
    BatMx7800ScandevicePlatform.instance.scan();
  }

  void setBroadcastOutputMode() {
    BatMx7800ScandevicePlatform.instance.setBroadcastOutputMode();
  }

  void closeScan() {
    BatMx7800ScandevicePlatform.instance.close();
  }

  void resetScan() {
    BatMx7800ScandevicePlatform.instance.reset();
  }

  set scanVibrate(bool value) =>
      BatMx7800ScandevicePlatform.instance.vibrate = value;

  set scanBeep(bool value) => BatMx7800ScandevicePlatform.instance.beep = value;

  bool get connected => BatMx7800ScandevicePlatform.instance.connected;
  bool get scanBeep => BatMx7800ScandevicePlatform.instance.beep;
  bool get scanVibrate => BatMx7800ScandevicePlatform.instance.vibrate;
}
