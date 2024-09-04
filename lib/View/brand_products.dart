import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/Widgets/product.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/text.dart';
import '../colors.dart';

class BrandProducts extends StatelessWidget {
  final HomeController controller = Get.find();
  final String category;
  final String brand;
  BrandProducts({
    super.key,
    required this.category,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        if (!controller.fetchedBrands[category]!
            .contains(brand.toLowerCase())) {
          controller.fetchBrandProducts(
            category.toLowerCase(),
            'brand',
            brand.toLowerCase(),
          );
        }
      },
    );
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (builder) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: MyAppBar(
              title: brand.capitalizeFirst!,
              leadingExists: true,
            ),
            body: (controller.fetchingBrandProducts)
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
                : (controller.fetchedProducts[category]!
                        .where(
                            (product) => product.brand == brand.capitalizeFirst)
                        .toList()
                        .isEmpty)
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
                          itemCount: controller.fetchedProducts[category]!
                              .where((product) =>
                                  product.brand == brand.capitalizeFirst)
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductCard(
                              product: controller.fetchedProducts[category]!
                                  .where((product) =>
                                      product.brand == brand.capitalizeFirst)
                                  .toList()[index],
                            );
                          },
                        ),
                      ),
          ),
        );
      },
    );
  }
}
