# bat_mx7800_scandevice

Flutter plugin for ScanDevice SDK for use on devices .BAT MX7800 Series.
With this plugin you can easily control the basic functions of barcode scanner of the device (open, close, manual scan, etc).


## Supported

- [x] MX7800-A
- [x] MX7800-X
- [x] MX7800-XR

- [x] Maybe work on your PDA with SDK version 2.1.1 or later. Test and enjoy!


## Installation

Add this to your package's pubspec.yaml file:

```
dependencies:
 bat_mx7800_scandevice: ^any
```

## Usage

- 1) Declare scanner

```dart
final scanner = BatMx7800Scandevice();
```

- 2) Initialize the interface with Init() method

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final scanOK = await scanner.init(); //MANDATORY.. INITIALIZE THE SCANNER INTERFACE
  runApp(const MyApp());
}
```

- 3) Create a listener for catch barcodes readed

```dart
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
```

## Contribute

We would ❤️ to see your contribution!

## Donate
Did you like this plugin? Give me a coffee 😍
https://www.paypal.com/donate/?hosted_button_id=C7W7WEY2HXEHU

## About

Created by Nilcemar Ferreira - .BAT Tecnologia
Made in Brazil 🇧🇷

instagram: @battecnologia
site: https://www.battecnologia.com
