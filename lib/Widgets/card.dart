import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/View/brand_products.dart';
import 'package:my_phone/Widgets/button.dart';
import 'package:my_phone/Widgets/text.dart';
import 'package:my_phone/colors.dart';
import 'package:sizer/sizer.dart';

class MyCard extends StatelessWidget {
  final Widget icon;
  final bool verticalView;
  final bool isBrand;
  final String categoryName;
  final String brandName;
  const MyCard({
    super.key,
    required this.icon,
    this.verticalView = false,
    this.categoryName = '',
    this.brandName = '',
    this.isBrand = false,
  });

  @override
  Widget build(BuildContext context) {
    return (verticalView)
        ? MyButton(
            buttonFunction: () {
              if (isBrand) {
                Get.to(
                  () => BrandProducts(
                    category: categoryName.toLowerCase(),
                    brand: brandName,
                  ),
                );
                print('1');
              } else {
                Get.toNamed('/${categoryName.toLowerCase()}');
                print('2');
              }
            },
            height: 85,
            width: 100.w - 32,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    color: MyColors().secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: icon,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                (isBrand)
                    ? MyText(
                        text: brandName.capitalizeFirst!,
                        size: 18,
                        weight: FontWeight.normal,
                        color: Colors.black,
                      )
                    : MyText(
                        text: categoryName.capitalizeFirst!,
                        size: 18,
                        weight: FontWeight.normal,
                        color: Colors.black,
                      ),
              ],
            ),
          )
        : MyButton(
            buttonFunction: () {
              Get.toNamed('/${categoryName.toLowerCase()}');
            },
            height: 85,
            width: 85,
            color: MyColors().secondaryColor,
            child: SizedBox(
              height: 40,
              width: 40,
              child: icon,
            ),
          );
  }
}
