import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Widgets/text.dart';

import 'colors.dart';

class CommonFunctions {
  Widget myTextBuilder(String text) => MyText(
        text: text,
        size: 16,
        weight: FontWeight.normal,
        color: Colors.black,
      );

  void showDialogue(bool isError, String errorText, Function? confirm,
      Function? exitDialogue, String? message) {
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async {
          if (exitDialogue != null) {
            exitDialogue();
          }
          return true;
        },
        child: Center(
          child: Container(
            height: 164,
            width: Get.width - 40,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: (isError) ? 'error occurred'.tr : 'confirmation'.tr,
                  size: 16,
                  weight: FontWeight.normal,
                  color: MyColors().myRed,
                  overflow: TextOverflow.visible,
                  decoration: TextDecoration.none,
                ),
                const SizedBox(height: 16),
                MyText(
                  text: (isError)
                      ? errorText
                      : message ??
                          'all the information you entered will be lost. are you sure you want to exit?'
                              .tr,
                  size: 14,
                  weight: FontWeight.normal,
                  color: Colors.black,
                  overflow: TextOverflow.visible,
                  decoration: TextDecoration.none,
                ),
                const SizedBox(height: 24),
                (isError)
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            if (exitDialogue != null) {
                              exitDialogue();
                            }
                            Get.back();
                          },
                          child: MyText(
                            text: 'okay'.tr,
                            size: 14,
                            weight: FontWeight.normal,
                            color: MyColors().myBlue,
                            overflow: TextOverflow.visible,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (exitDialogue != null) {
                                exitDialogue();
                              }
                              Get.back();
                            },
                            child: MyText(
                              text: 'cancel'.tr,
                              size: 14,
                              weight: FontWeight.normal,
                              color: MyColors().myRed,
                              overflow: TextOverflow.visible,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              if (exitDialogue != null) {
                                exitDialogue();
                              }
                              if (confirm != null) {
                                confirm();
                              }
                            },
                            child: MyText(
                              text: 'okay'.tr,
                              size: 14,
                              weight: FontWeight.normal,
                              color: MyColors().myBlue,
                              overflow: TextOverflow.visible,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? email) =>
      EmailValidator.validate(email!.trim()) ? null : 'enter a valid email.'.tr;

  String? validatePassword(String? password) => (password!.length > 5)
      ? null
      : 'password must be more than 6 characters.'.tr;

  String? validateName(String? name) =>
      (name!.isEmpty) ? 'enter a valid full name.'.tr : null;
}
