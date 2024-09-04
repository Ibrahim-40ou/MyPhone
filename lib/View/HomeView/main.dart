import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/View/best_selling_view.dart';
import 'package:my_phone/Widgets/best_selling.dart';
import 'package:my_phone/Widgets/card.dart';
import 'package:my_phone/Widgets/text.dart';
import 'package:my_phone/Widgets/text_form_field.dart';
import 'package:my_phone/colors.dart';
import 'package:sizer/sizer.dart';
import '../CategoriesView/all_categories.dart';
import '../product_view.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    MyField(
                      width: 100.w,
                      controller: controller.searchController,
                      hintText: 'search'.tr,
                      isPassword: false,
                      isLast: true,
                      isName: true,
                      isSearch: true,
                      search: controller.searchProducts,
                      type: TextInputType.text,
                      prefixIcon: const Icon(Icons.search),
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 200,
                        width: 100.w,
                        child: controller.fetchingOffers
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
                            : controller.offers.isEmpty
                                ? const Center(
                                    child: MyText(
                                      text: 'There are no offers.',
                                      size: 16,
                                      weight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  )
                                : PageView.builder(
                                    itemCount: controller.offers.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => ProductView(
                                                product:
                                                    controller.offers[index],
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: SizedBox(
                                              height: 200,
                                              width: 100.w,
                                              child: CachedNetworkImage(
                                                imageUrl: controller
                                                    .offers[index].image!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: MyColors().myBlue,
                                                      strokeWidth: 2,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  Icons.error,
                                                  color: MyColors().myRed,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MyText(
                          text: 'categories'.tr,
                          size: 20,
                          weight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const Categories());
                          },
                          child: MyText(
                            text: 'view all'.tr,
                            size: 14,
                            weight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyCard(
                          icon: Image.asset('assets/phones.png'),
                          categoryName: 'phones',
                        ),
                        MyCard(
                          icon: Image.asset('assets/laptops.png'),
                          categoryName: 'laptops',
                        ),
                        MyCard(
                          icon: Image.asset('assets/headphones.png'),
                          categoryName: 'headphones',
                        ),
                        MyCard(
                          icon: Image.asset('assets/smartwatches.png'),
                          categoryName: 'watches',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MyText(
                          text: 'best selling'.tr,
                          size: 20,
                          weight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const BestSellingView());
                          },
                          child: MyText(
                            text: 'view all'.tr,
                            size: 14,
                            weight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    (controller.fetchingBestSelling)
                        ? SizedBox(
                            height: 252,
                            child: Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: MyColors().myBlue,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          )
                        : (controller.fetchingBestSelling)
                            ? SizedBox(
                                height: 252,
                                child: Center(
                                  child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: MyColors().myBlue,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              )
                            : (controller.bestSelling.isEmpty)
                                ? SizedBox(
                                    height: 252,
                                    width: 100.w,
                                    child: Center(
                                      child: MyText(
                                        text: 'there are no products.'.tr,
                                        size: 16,
                                        weight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 100.w,
                                    height: 252,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          min(controller.bestSelling.length, 4),
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              BestSelling(
                                        product: controller.bestSelling[index],
                                      ),
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(width: 20),
                                    ),
                                  )
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
