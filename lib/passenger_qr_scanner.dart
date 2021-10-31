import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_application/scan_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PassengerQRScanner extends StatefulWidget {
  const PassengerQRScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PassengerQRScannerState();
}

class _PassengerQRScannerState extends State<PassengerQRScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    log('message');
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  result != null
                      ? Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, top: 0, bottom: 0),
                          child: const Text('PLACE YOUR QR IN THE BOX',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //           onPressed: () async {
                  //             await controller?.toggleFlash();
                  //             setState(() {});
                  //           },
                  //           child: FutureBuilder(
                  //             future: controller?.getFlashStatus(),
                  //             builder: (context, snapshot) {
                  //               return Text('Flash: ${snapshot.data}');
                  //             },
                  //           )),
                  //     ),
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //           onPressed: () async {
                  //             await controller?.flipCamera();
                  //             setState(() {});
                  //           },
                  //           child: FutureBuilder(
                  //             future: controller?.getCameraInfo(),
                  //             builder: (context, snapshot) {
                  //               if (snapshot.data != null) {
                  //                 return Text(
                  //                     'Camera facing ${describeEnum(snapshot.data!)}');
                  //               } else {
                  //                 return const Text('loading');
                  //               }
                  //             },
                  //           )),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //         onPressed: () async {
                  //           await controller?.pauseCamera();
                  //         },
                  //         child: const Text('pause',
                  //             style: TextStyle(fontSize: 20)),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //         onPressed: () async {
                  //           await controller?.resumeCamera();
                  //         },
                  //         child: const Text('resume',
                  //             style: TextStyle(fontSize: 20)),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 290.0
        : 290.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      cameraFacing: CameraFacing.front,
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        setState(() {
          var scanData = result?.code;
          controller.pauseCamera();
          Navigator.of(context)
              .push(CupertinoPageRoute(
                  builder: (context) =>
                      ScanSuccess(journeyType: 'started', scanData: scanData)))
              .then((val) {
            setState(() {
              controller.resumeCamera();
            });
          });
        });
      }
    });
  }

  void showSuccessMessage() {
    AwesomeDialog(
            context: context,
            title: 'Scan complete',
            dialogType: DialogType.SUCCES,
            buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
            headerAnimationLoop: false,
            animType: AnimType.BOTTOMSLIDE,
            desc: 'Dialog description here...',
            showCloseIcon: true,
            body: const Text('Test'))
        .show();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
