import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/Widgets/product.dart';
import 'package:my_phone/Widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../colors.dart';

class BestSellingView extends StatelessWidget {
  const BestSellingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: const MyAppBar(
              title: 'Best Selling',
              leadingExists: true,
            ),
            body: (controller.fetchingBestSelling)
                ? Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: MyColors().myBlue,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : (controller.bestSelling.isEmpty)
                    ? const Center(
                        child: MyText(
                          text: 'There are no products.',
                          size: 16,
                          weight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      )
                    : SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return ProductCard(
                              product: controller.bestSelling[index],
                            );
                          },
                          itemCount: controller.bestSelling.length,
                        ),
                      ),
          ),
        );
      },
    );
  }
}
