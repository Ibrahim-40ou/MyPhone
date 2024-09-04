import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/Widgets/card.dart';

class Laptops extends StatelessWidget {
  const Laptops({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: const MyAppBar(
              title: 'Laptops',
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
                        icon: Image.asset('assets/apple.png'),
                        verticalView: true,
                        categoryName: 'laptops',
                        brandName: 'Apple',
                        isBrand: true,
                      ),
                      const SizedBox(height: 20),
                      MyCard(
                        icon: Image.asset('assets/samsung.png'),
                        verticalView: true,
                        categoryName: 'laptops',
                        brandName: 'Samsung',
                        isBrand: true,
                      ),
                      const SizedBox(height: 20),
                      MyCard(
                        icon: Image.asset('assets/huawei.png'),
                        verticalView: true,
                        categoryName: 'laptops',
                        brandName: 'Huawei',
                        isBrand: true,
                      ),
                      const SizedBox(height: 20),
                      MyCard(
                        icon: Image.asset('assets/hp.png'),
                        verticalView: true,
                        categoryName: 'laptops',
                        brandName: 'hp',
                        isBrand: true,
                      ),
                      const SizedBox(height: 20),
                      MyCard(
                        icon: Image.asset('assets/asus.png'),
                        verticalView: true,
                        categoryName: 'laptops',
                        brandName: 'Asus',
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
