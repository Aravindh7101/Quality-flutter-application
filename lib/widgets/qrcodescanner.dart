import 'package:ddbm_application/Pages/homePage.dart';
import 'package:ddbm_application/Service/cache.dart';
import 'package:ddbm_application/custom/custom.dart';
import 'package:ddbm_application/helper/home_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart'; // Import the vibration package

class QRCodeScanner extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends ConsumerState<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  int scanCount = 0;
  Future<void>? _scannerReadyFuture;
  Set<String> scannedSet = Set();

  @override
  void initState() {
    super.initState();
    _scannerReadyFuture = Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final helper = ref.read(homeHelper);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan QR Code (${scanCount.toString()})',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Customcolor().blacktheme,
        actions: [
          ref.watch(homeHelper).date != null
              ? Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Text(' Online')
                  ],
                )
              : Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Text(' Offline')
                  ],
                ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              _showScannedDataList();
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _scannerReadyFuture,
        builder: (context, snapshot) {
          ref.read(homeHelper).scanName.text =
              ref.read(homeHelper).scanlist.join("");
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderRadius: 10,
                    borderColor: Customcolor().blacktheme,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
                Positioned(
                  bottom: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Text(
                      helper.scanlist.isEmpty
                          ? 'No QR codes scanned yet.'
                          : 'Latest QR: ${helper.scanlist.last}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    final helper = ref.read(homeHelper);

    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      final code = scanData.code!;
      if (!scannedSet.contains(code)) {
        setState(() {
          helper.scanlist.add(code);
          scanCount = helper.scanlist.length;
          scannedSet.add(code);
          getdata();
          // Vibrate the phone when a QR code is scanned
          _vibrate();

          // Show a popup for the scanned QR code
          _showScannedQRPopup(code);
        });
      }
    });
  }

  getdata() async {
    getAccessValue = await Cache().getAccessValue();
    // print(getAccessValue);
    // setState(() {});
    getAccessValue = await Cache().getAccessValue();
    // print(getAccessValue);
    // setState(() {});
    if (getAccessValue == 'ot') {
      print('prvot');
      Customcolor().blacktheme = Colors.red;
      print(Customcolor().blacktheme);
      Future.microtask(() => ref.read(homeHelper).getserverHour());
      // Define the static start time as 10:00 AM
      final DateTime startTime = DateTime.now().add(Duration(hours: 10));

      // Define the dynamic end time as a string
      // final String endTimeString = "17:00";
      // Get the current time
      DateTime now = DateTime.now();

      // Parse the dynamic end time string into a DateTime object
      List<String> endTimeParts = ref.read(homeHelper).servertime.split(":");
      DateTime endTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(endTimeParts[0]),
        int.parse(endTimeParts[1]),
      );

      // Check if the current time is before 10:00 AM or after the dynamic end time
      bool isBefore10AMOrAfterEndTime =
          now.isBefore(startTime) || now.isAfter(endTime);
      // print(isBefore10AMOrAfterEndTime);
      // print(ref.read(homeHelper).servertime);
      if (isBefore10AMOrAfterEndTime == true) {
        Future.microtask(() => ref.read(homeHelper).getserverdate());
      } else {
        Future.microtask(() => ref.read(homeHelper).getpreviousotserverdate());
      }
    } else if (getAccessValue == 'admin') {
      print('prv');

      Future.microtask(() => ref.read(homeHelper).getpreviousserverdate());
    } else {
      // print('datess');
      print('ss:${getAccessValue}');
      Future.microtask(() => ref.read(homeHelper).getserverdate());
    }
  }

  void _vibrate() async {
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != null && hasVibrator) {
      Vibration.vibrate(duration: 500);
    }
  }

  void _showScannedQRPopup(String code) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('QR Code Scanned'),
          content: Text('Scanned QR Code: $code'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showScannedDataList() {
    final helper = ref.read(homeHelper);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scanned Data List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (String data in helper.scanlist)
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(data),
                ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
