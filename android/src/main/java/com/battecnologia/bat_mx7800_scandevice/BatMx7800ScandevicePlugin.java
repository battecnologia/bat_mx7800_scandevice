package com.battecnologia.bat_mx7800_scandevice;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.device.ScanDevice;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.EventChannel;

/** BatMx7800ScandevicePlugin */
public class BatMx7800ScandevicePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native
  /// Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine
  /// and unregister it
  /// when the Flutter Engine is detached from the Activity

  ScanDevice sm = new ScanDevice();
  private static final String EVENT_CHANNEL = "scandevice.events";
  private static final String METHOD_CHANNEL = "scandevice.methods";
  private final static String SCAN_ACTION = "scan.rcv.message";
  private EventChannel.EventSink scannerToFlutterSink;
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), METHOD_CHANNEL);
    channel.setMethodCallHandler(this);

    new EventChannel(flutterPluginBinding.getBinaryMessenger(), EVENT_CHANNEL)
        .setStreamHandler(new EventChannel.StreamHandler() {
          @Override
          public void onListen(Object args, EventChannel.EventSink eventSink) {
            scannerToFlutterSink = eventSink;
          }

          @Override
          public void onCancel(Object listener) {
            mScanReceiver.abortBroadcast();
          }
        });

    IntentFilter filter = new IntentFilter(SCAN_ACTION);
    new ContextWrapper(context).registerReceiver(mScanReceiver, filter);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    // scanner api methods call from SDK

    switch (call.method) {
      case "open":
        sm.openScan();
        break;
      case "scan":
        sm.startScan();
        break;
      case "setBroadcastOutScanMode":
        sm.setOutScanMode(0);
        break;
      case "setEditboxOutScanMode":
        sm.setOutScanMode(1);
        break;
      case "setKeyboardOutScanMode":
        sm.setOutScanMode(2);
        break;
      case "setSingleOutScanMode":
        sm.setOutScanMode(3);
        break;
      case "beep":
        result.success(sm.getScanBeepState());
        break;
      case "beepOn":
        sm.setScanBeep();
        break;
      case "beepOff":
        sm.setScanUnBeep();
        break;
      case "vibrate":
        result.success(sm.getScanVibrateState());
        break;
      case "vibrateOn":
        sm.setScanVibrate();
        break;
      case "vibrateOff":
        sm.setScanUnVibrate();
        break;
      case "close":
        sm.stopScan();
        sm.closeScan();
        break;
      case "reset":
        sm.resetScan();
        break;
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);

      default:
        result.notImplemented();
    }

  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    new ContextWrapper(context).unregisterReceiver(mScanReceiver); // disable receiver
  }

  private BroadcastReceiver mScanReceiver = new BroadcastReceiver() {
    @Override
    public void onReceive(Context context, Intent intent) {
      byte[] barocode = intent.getByteArrayExtra("barocode");
      int barocodelen = intent.getIntExtra("length", 0);
      scannerToFlutterSink.success(new String(barocode, 0, barocodelen));
    }
  };
}
