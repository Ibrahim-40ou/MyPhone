import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/Widgets/card.dart';

class SmartBands extends StatelessWidget {
  const SmartBands({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: const MyAppBar(
              title: 'Smart Bands',
              leadingExists: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      MyCard(
                        icon: Image.asset('assets/samsung.png'),
                        verticalView: true,
                        categoryName: 'bands',
                        brandName: 'Samsung',
                        isBrand: true,
                      ),
                      const SizedBox(height: 20),
                      MyCard(
                        icon: Image.asset('assets/huawei.png'),
                        verticalView: true,
                        categoryName: 'bands',
                        brandName: 'Huawei',
                        isBrand: true,
                      ),
                      const SizedBox(height: 20),
                      MyCard(
                        icon: Image.asset('assets/xiaomi.png'),
                        verticalView: true,
                        categoryName: 'bands',
                        brandName: 'Xiaomi',
                        isBrand: true,
                      ),
                      const SizedBox(height: 20),
                      MyCard(
                        icon: Image.asset('assets/googleIcon.png'),
                        verticalView: true,
                        categoryName: 'bands',
                        brandName: 'Google',
                        isBrand: true,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
