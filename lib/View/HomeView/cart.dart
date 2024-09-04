import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/View/checkout.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/common_functions.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/button.dart';
import '../../Widgets/cart_item.dart';
import '../../Widgets/text.dart';
import '../../colors.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: MyAppBar(
              title: 'Cart',
              leadingExists: (controller.editingCart) ? true : false,
              leadingFunction: () {
                CommonFunctions().showDialogue(
                  false,
                  '',
                  () {
                    controller.cancelCartEdit();
                    Get.back();
                  },
                  null,
                  'Are you sure you want to cancel cart edit? Selected items will be unselected.',
                );
              },
              actionExists: controller.cart.isNotEmpty ? true : false,
              actionFunction: () {
                if (controller.editingCart) {
                  CommonFunctions().showDialogue(
                    false,
                    '',
                    controller.deleteItems,
                    null,
                    'Selected Items will be deleted from your cart. Are you sure you want to continue?',
                  );
                } else {
                  controller.toggleCartEdit(true);
                }
              },
              icon: (controller.editingCart)
                  ? Icon(
                      Icons.delete,
                      size: 24,
                      color: MyColors().myRed,
                    )
                  : const Icon(
                      Icons.edit,
                      size: 24,
                      color: Colors.black,
                    ),
            ),
            body: (controller.fetchingCartItems)
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
                : (controller.cart.isEmpty)
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: MyText(
                            text:
                                'Cart is empty.\nAdd products to your cart to find them here.',
                            size: 16,
                            weight: FontWeight.normal,
                            color: Colors.black,
                            overflow: TextOverflow.visible,
                            align: TextAlign.center,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.cart.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CartItem(item: controller.cart[index]);
                              },
                            ),
                          ),
                          if (controller.cart.isNotEmpty)
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 10.h,
                              color: MyColors().secondaryColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        text: 'Price',
                                        size: 22,
                                        weight: FontWeight.bold,
                                        color: MyColors().mainColor,
                                      ),
                                      MyText(
                                        text: '\$${controller.totalPrice}',
                                        size: 18,
                                        weight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  MyButton(
                                    buttonFunction: () {
                                      Get.to(() => const Checkout());
                                    },
                                    height: 50,
                                    width: 40.w,
                                    color: MyColors().mainColor,
                                    child: const MyText(
                                      text: 'Checkout',
                                      size: 16,
                                      weight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
          ),
        );
      },
    );
  }
}
