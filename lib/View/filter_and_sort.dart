import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/Widgets/button.dart';
import 'package:my_phone/Widgets/dropdown.dart';
import 'package:my_phone/Widgets/text.dart';
import 'package:my_phone/Widgets/text_form_field.dart';
import 'package:my_phone/colors.dart';
import 'package:my_phone/common_functions.dart';
import 'package:sizer/sizer.dart';

class FilterAndSort extends StatelessWidget {
  const FilterAndSort({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (controller.editingFilters) {
              CommonFunctions().showDialogue(
                false,
                '',
                controller.onLeaveFilters,
                null,
                'Are you sure you want to exit the page? Filters applied will be lost.',
              );
            } else {
              Get.back();
            }
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: MyAppBar(
                title: 'Filter and Sort',
                leadingExists: true,
                leadingFunction: () {
                  if (controller.editingFilters) {
                    CommonFunctions().showDialogue(
                      false,
                      '',
                      controller.onLeaveFilters,
                      null,
                      'Are you sure you want to exit the page? Filters applied will be lost.',
                    );
                  } else {
                    Get.back();
                  }
                },
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyDropdown(
                          enabled: controller.editingFilters,
                          width: (100.w - 42) / 2,
                          hintText: 'Category',
                          value: controller.category,
                          items: controller.categories,
                          changeValue: controller.selectCategory,
                          icon: const Icon(
                            Icons.menu,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                        MyDropdown(
                          enabled: controller.editingFilters,
                          width: (100.w - 42) / 2,
                          hintText: 'Brand',
                          value: controller.brand,
                          items: controller.brands,
                          changeValue: controller.selectBrand,
                          icon: const Icon(
                            CupertinoIcons.tag_fill,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyField(
                          enabled: controller.editingFilters,
                          width: (100.w - 42) / 2,
                          controller: controller.minPriceController,
                          hintText: 'Min Price',
                          isPassword: false,
                          isLast: false,
                          isName: false,
                          type: TextInputType.number,
                          prefixIcon: const Icon(
                            CupertinoIcons.money_dollar,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                        MyField(
                          enabled: controller.editingFilters,
                          width: (100.w - 42) / 2,
                          controller: controller.maxPriceController,
                          hintText: 'Max Price',
                          isPassword: false,
                          isLast: false,
                          isName: false,
                          type: TextInputType.number,
                          prefixIcon: const Icon(
                            CupertinoIcons.money_dollar,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyField(
                          enabled: controller.editingFilters,
                          width: (100.w - 42) / 2,
                          controller: controller.capacityController,
                          hintText: 'Capacity',
                          isPassword: false,
                          isLast: false,
                          isName: false,
                          type: TextInputType.number,
                          prefixIcon: const Icon(
                            Icons.storage,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                        MyField(
                          enabled: controller.editingFilters,
                          width: (100.w - 42) / 2,
                          controller: controller.ramController,
                          hintText: 'RAM',
                          isPassword: false,
                          isLast: false,
                          isName: false,
                          type: TextInputType.number,
                          prefixIcon: const Icon(
                            Icons.memory,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MyDropdown(
                      enabled: controller.editingFilters,
                      width: 100.w,
                      hintText: 'Sort by price',
                      value: controller.priceSort,
                      items: controller.sortByPrice,
                      changeValue: controller.selectPriceSort,
                      icon: const Icon(
                        CupertinoIcons.money_dollar,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 40),
                    (controller.editingFilters)
                        ? Column(
                            children: [
                              MyButton(
                                buttonFunction: () {
                                  controller.finishEditingFilters();
                                  controller.searchProducts();
                                },
                                height: 40,
                                width: 100.w,
                                color: MyColors().mainColor,
                                child: const MyText(
                                  text: 'Save Changes',
                                  size: 16,
                                  weight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              MyButton(
                                buttonFunction: () {
                                  CommonFunctions().showDialogue(
                                    false,
                                    '',
                                    controller.cancelEditingFilters,
                                    null,
                                    'Are you sure you want to cancel applying filters? All filters selected will be lost.',
                                  );
                                },
                                height: 40,
                                width: 100.w,
                                color: MyColors().myRed,
                                child: const MyText(
                                  text: 'Cancel',
                                  size: 16,
                                  weight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : MyButton(
                            buttonFunction: controller.editFilters,
                            height: 40,
                            width: 100.w,
                            color: MyColors().mainColor,
                            child: const MyText(
                              text: 'Edit Filters',
                              size: 16,
                              weight: FontWeight.normal,
                              color: Colors.white,
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
