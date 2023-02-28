import 'package:diyo/component/diyo_scaffold.dart';
import 'package:diyo/controller/checkout_controller.dart';
import 'package:diyo/controller/menu_controller.dart';
import 'package:diyo/controller/resto_controller.dart';
import 'package:diyo/model/resto.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:diyo/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool isVerifying = false;
  bool isValid = true;
  Resto? targetResto;
  String verifyErrorMsg = "";
  RestoController restoController = Get.find<RestoController>();
  MenuController menuController = Get.find<MenuController>();
  CheckoutController checkoutController = Get.find<CheckoutController>();
  final MobileScannerController mobileScannerController =
      MobileScannerController(
    returnImage: false,
    detectionSpeed: DetectionSpeed.normal,
    autoStart: true,
    torchEnabled: false,
    facing: CameraFacing.back,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mobileScannerController.start(cameraFacingOverride: CameraFacing.back);
      setState(() {
        isVerifying = false;
        isValid = true;
        verifyErrorMsg = "";
      });
    });
  }

  @override
  void dispose() {
    DiyoUtill.logger.w("Dispose QR Scanner");
    try {
      mobileScannerController.dispose();
    } catch (e) {
      DiyoUtill.logger.e(e);
    }
    super.dispose();
  }

  void verifyBarcode(BarcodeCapture campture) async {
    var barcodes = campture.barcodes;
    if (barcodes.isNotEmpty) {
      setState(() {
        isVerifying = true;
      });
      String? code = barcodes.first.rawValue;
      if (code != null) {
        var resto = await DiyoUtill.verifyQRCode(code);
        if (resto != null) {
          //check resto berbeda
          if (restoController.expectedViewedResto.value.id != 0 &&
              resto.id != restoController.expectedViewedResto.value.id) {
            setState(() {
              isValid = false;
              verifyErrorMsg =
                  "QR code yang anda scan merupakan QR untuk ${resto.name}, silahkan gunakan QR code yang valid untuk ${restoController.expectedViewedResto.value.name}";
            });
            return;
          }
          DiyoUtill.logger.d(resto.toJson());
          restoController.setViewedResto(resto);
          checkoutController.clearCartItem();
          return Get.offNamed("/resto-detail");
        }
      }
      setState(() {
        isValid = false;
        verifyErrorMsg =
            "Kode $code tidak tervalidasi, silahkan lakukan scan ulang pada qr code yang valid";
      });
      return;
    }
    mobileScannerController.start();
  }

  void reScan() {
    setState(() {
      isVerifying = false;
      isValid = true;
      verifyErrorMsg = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    Rect scannerRect = Rect.fromCenter(
        center: Offset(MediaQuery.of(context).size.width / 2,
            MediaQuery.of(context).size.height * 0.4),
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.width * 0.90);

    return WillPopScope(
      onWillPop: () {
        return Future(() {
          mobileScannerController.dispose();
          return true;
        });
      },
      child: DiyoScaffold(
        backgroundColor: Colors.black,
        useBottomBar: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            MobileScanner(
              controller: mobileScannerController,
              fit: BoxFit.contain,
              onDetect: verifyBarcode,
            ),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.srcOut),
              child: Stack(fit: StackFit.expand, children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut),
                ),
                Positioned.fromRect(
                    rect: scannerRect,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ))
              ]),
            ),
            Positioned.fromRect(
                rect: scannerRect,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/image/qr_frame.png"))),
                )),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.5 + 20,
                left: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: mobileScannerController.torchState,
                      builder: (context, state, child) {
                        switch (state) {
                          case TorchState.off:
                            return const Icon(Icons.flash_off,
                                color: Colors.grey);
                          case TorchState.on:
                            return const Icon(Icons.flash_on,
                                color: Colors.white);
                        }
                      },
                    ),
                    iconSize: 28.0,
                    onPressed: () => mobileScannerController.toggleTorch(),
                  ),
                )),
            Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 18),
                      child: Obx(() => Text(
                            restoController.expectedViewedResto.value.id == 0
                                ? "Silahkan Scan Barcode yang ada di meja"
                                : "Silahkan Scan Barcode yang ada di meja ${restoController.expectedViewedResto.value.name}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: DiyoThemeFont.sizeBodyCopy),
                          )),
                    ))),
            isVerifying
                ? Positioned.fromRect(
                    rect: Rect.fromCenter(
                      center: Offset(MediaQuery.of(context).size.width / 2,
                          MediaQuery.of(context).size.height * 0.4),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(227, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: !isValid
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error,
                                  size: 48,
                                  color: DiyoTheme.diyotheme,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  verifyErrorMsg,
                                  style: TextStyle(
                                      color: DiyoThemeFont.blackFontColor,
                                      fontWeight: FontWeight.w600,
                                      height: 1.333,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                MaterialButton(
                                  onPressed: reScan,
                                  color: DiyoTheme.diyotheme,
                                  textColor: Colors.white,
                                  child: Text(
                                    "Tutup",
                                    style: TextStyle(
                                        fontSize: DiyoThemeFont.sizeH3),
                                  ),
                                )
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
