import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/Widgets/card.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: const MyAppBar(
              title: 'Categories',
              leadingExists: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    MyCard(
                      icon: Image.asset('assets/phones.png'),
                      verticalView: true,
                      categoryName: 'phones',
                    ),
                    const SizedBox(height: 20),
                    MyCard(
                      icon: Image.asset('assets/laptops.png'),
                      verticalView: true,
                      categoryName: 'laptops',
                    ),
                    const SizedBox(height: 20),
                    MyCard(
                      icon: Image.asset('assets/headphones.png'),
                      verticalView: true,
                      categoryName: 'headphones',
                    ),
                    const SizedBox(height: 20),
                    MyCard(
                      icon: Image.asset('assets/smartwatches.png'),
                      verticalView: true,
                      categoryName: 'watches',
                    ),
                    const SizedBox(height: 20),
                    MyCard(
                      icon: Image.asset('assets/smartbands.png'),
                      verticalView: true,
                      categoryName: 'bands',
                    ),
                    const SizedBox(height: 20),
                    MyCard(
                      icon: Image.asset('assets/chargersAndCables.png'),
                      verticalView: true,
                      categoryName: 'chargers',
                    ),
                    const SizedBox(height: 20),
                    MyCard(
                      icon: Image.asset('assets/cases.png'),
                      verticalView: true,
                      categoryName: 'cases',
                    ),
                    const SizedBox(height: 20),
                    MyCard(
                      icon: Image.asset('assets/others.png'),
                      verticalView: true,
                      categoryName: 'others',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
