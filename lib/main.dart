import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_phone/View/AuthView/password_reset.dart';
import 'package:my_phone/View/CategoriesView/cases.dart';
import 'package:my_phone/View/CategoriesView/chargers_and_cables.dart';
import 'package:my_phone/View/CategoriesView/headphones.dart';
import 'package:my_phone/View/CategoriesView/laptops.dart';
import 'package:my_phone/View/CategoriesView/others.dart';
import 'package:my_phone/View/CategoriesView/phones.dart';
import 'package:my_phone/View/CategoriesView/smart_bands.dart';
import 'package:my_phone/View/CategoriesView/smart_watches.dart';
import 'package:my_phone/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'Bindings/auth_bindings.dart';
import 'Bindings/home_bindings.dart';
import 'View/AuthView/login.dart';
import 'View/AuthView/register.dart';
import 'View/HomeView/home.dart';
import 'firebase_options.dart';

SharedPreferences? loginCheck;
SharedPreferences? langCheck;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.white),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  loginCheck = await SharedPreferences.getInstance();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLanguageCode = prefs.getString('languageCode');

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        translations: MyTranslations(),
        locale: savedLanguageCode != null
            ? Locale(savedLanguageCode)
            : const Locale('en'),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
        getPages: [
          GetPage(
            name: '/',
            page: () => loginCheck!.getString('loggedIn') == null
                ? const Login()
                : const Home(),
            bindings: (loginCheck!.getString('loggedIn') == null)
                ? [AuthBindings()]
                : [AuthBindings(), HomeBindings()],
          ),
          GetPage(
            name: '/password_reset',
            page: () => const PasswordReset(),
            binding: AuthBindings(),
          ),
          GetPage(
            name: '/create_profile',
            page: () => const Register(),
            binding: AuthBindings(),
          ),
          GetPage(
            name: '/home',
            page: () => const Home(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/phones',
            page: () => const Phones(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/laptops',
            page: () => const Laptops(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/headphones',
            page: () => const Headphones(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/watches',
            page: () => const SmartWatches(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/bands',
            page: () => const SmartBands(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/chargers',
            page: () => const ChargersAndCables(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/cases',
            page: () => const Cases(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/others',
            page: () => const Others(),
            binding: HomeBindings(),
          ),
        ],
      ),
    ),
  );
}
