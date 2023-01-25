import 'package:flutter/material.dart';
import 'package:bat_mx7800_scandevice/bat_mx7800_scandevice.dart';

final scanner = BatMx7800Scandevice();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await scanner.init(); //MANDATORY.. INITIALIZE THE SCANNER INTERFACE
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _barcodeReaded = '-----';

  @override
  void initState() {
    super.initState();

    //add listenner for capture the readed barcode
    scanner.listeners.add((message) {
      setState(() {
        _barcodeReaded = message;
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('.BAT MX7800 Series Barcode Test'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      child: const Text('Open Scan'),
                      onPressed: () => scanner.openScan()),
                  ElevatedButton(
                      child: const Text('Close Scan'),
                      onPressed: () => scanner.closeScan()),
                  ElevatedButton(
                      child: const Text('Scan'),
                      onPressed: () => scanner.scan()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Vibrate on scan'),
                      Switch(
                        value: scanner.scanVibrate,
                        onChanged: (s) =>
                            setState(() => scanner.scanVibrate = s),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Beep on Scan'),
                      Switch(
                        value: scanner.scanBeep,
                        onChanged: (s) => setState(() => scanner.scanBeep = s),
                      ),
                    ],
                  ),
                  Text(
                    _barcodeReaded,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.amber[900]),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
