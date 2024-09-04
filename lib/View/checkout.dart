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

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: const MyAppBar(
              title: 'Checkout',
              leadingExists: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.checkoutFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyField(
                          width: 100.w,
                          controller: controller.recipientFullNameController,
                          hintText: 'Full Name',
                          isPassword: false,
                          isLast: false,
                          isName: true,
                          type: TextInputType.text,
                          prefixIcon: const Icon(
                            Icons.account_circle,
                            color: Colors.black,
                            size: 24,
                          ),
                          validatorFunction: CommonFunctions().validateName,
                        ),
                        const SizedBox(height: 20),
                        MyField(
                          width: 100.w,
                          controller: controller.recipientPhoneNumberController,
                          hintText: 'Phone Number',
                          isPassword: false,
                          isLast: false,
                          isName: false,
                          type: TextInputType.number,
                          prefixIcon: const Icon(
                            Icons.numbers,
                            size: 24,
                            color: Colors.black,
                          ),
                          validatorFunction: controller.validatePhoneNumber,
                        ),
                        const SizedBox(height: 20),
                        MyDropdown(
                          width: 100.w,
                          hintText: 'Governorate',
                          value: controller.governorate,
                          items: controller.governorates,
                          changeValue: controller.selectGovernorate,
                          icon: const Icon(
                            Icons.location_city,
                            size: 24,
                            color: Colors.black,
                          ),
                          validatorFunction: controller.validateGovernorate,
                        ),
                        const SizedBox(height: 20),
                        MyField(
                          width: 100.w,
                          controller: controller.closestKnownPointController,
                          hintText: 'Closes Known Point',
                          isPassword: false,
                          isLast: true,
                          isName: true,
                          type: TextInputType.text,
                          prefixIcon: const Icon(
                            Icons.location_on,
                            size: 24,
                            color: Colors.black,
                          ),
                          validatorFunction: controller.validateLocation,
                        ),
                        const SizedBox(height: 40),
                        MyButton(
                          buttonFunction: () async {
                            if (controller.checkoutFormKey.currentState!
                                .validate()) {
                              await controller.confirmOrder();
                              if (controller.successfullyPlaced) {
                                Get.back();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 20,
                                    ),
                                    content: const Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 24,
                                        ),
                                        SizedBox(width: 8),
                                        MyText(
                                          text:
                                              'You order is successfully placed.',
                                          size: 16,
                                          weight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    duration: const Duration(seconds: 3),
                                    backgroundColor: Colors.black,
                                  ),
                                );
                                controller.clearCheckout();
                              }
                            }
                          },
                          disabled: controller.confirmingOrder,
                          height: 40,
                          width: 100.w,
                          color: MyColors().mainColor,
                          child: (controller.confirmingOrder)
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    MyText(
                                      text: 'Confirming Order',
                                      size: 16,
                                      weight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              : const MyText(
                                  text: 'Confirm Order',
                                  size: 16,
                                  weight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                        ),
                      ],
                    ),
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
