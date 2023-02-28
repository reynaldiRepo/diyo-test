import 'package:diyo/controller/checkout_controller.dart';
import 'package:diyo/controller/menu_controller.dart';
import 'package:diyo/controller/navigation_controller.dart';
import 'package:diyo/controller/resto_controller.dart';
import 'package:diyo/screen/checkout_screen.dart';
import 'package:diyo/screen/home_screen.dart';
import 'package:diyo/screen/menu_detail.dart';
import 'package:diyo/screen/qr_code_scanner.dart';
import 'package:diyo/screen/resto_detail.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:wakelock/wakelock.dart';
import 'firebase_options.dart';

void main() async {
  var logger = Logger();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Wakelock.enable();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    logger.e(e.toString());
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const DiyoApp());
  });
}

class DiyoApp extends StatefulWidget {
  const DiyoApp({super.key});

  @override
  State<DiyoApp> createState() => _DiyoAppState();
}

class _DiyoAppState extends State<DiyoApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Diyo",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      initialBinding: BindingsBuilder(() {
        Get.put(NavigationController());
        Get.put(RestoController());
        Get.put(MenuController());
        Get.put(CheckoutController());
      }),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: DiyoTheme.diyotheme,
          primarySwatch: DiyoTheme.diyotheme,
          textTheme: GoogleFonts.interTextTheme()),
      getPages: [
        GetPage(
          name: "/",
          page: () => const HomeScreen(
            key: Key("HomeScreen"),
          ),
        ),
        GetPage(
            name: "/scanner",
            page: () => const ScannerScreen(
                  key: Key("ScannerScreen"),
                ),
            transition: Transition.downToUp),
        GetPage(
          name: "/resto-detail",
          page: () => const RestoDetail(
            key: Key("RestoDetail"),
          ),
        ),
        GetPage(
          name: "/menu-detail",
          page: () => const MenuDetail(
            key: Key("MenuDetail"),
          ),
        ),
        GetPage(
          name: "/checkout",
          page: () => const CheckOutScreen(
            key: Key("CheckoutScreen"),
          ),
        )
      ],
    );
  }
}
