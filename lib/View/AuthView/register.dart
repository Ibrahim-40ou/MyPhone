import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/auth_controller.dart';
import 'package:my_phone/common_functions.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text.dart';
import '../../Widgets/text_form_field.dart';
import '../../colors.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        if (controller.registerError) {
          Future.microtask(
            () => CommonFunctions().showDialogue(
              controller.registerError,
              controller.errorText,
              null,
              controller.exitDialogue,
              null,
            ),
          );
        }
        return WillPopScope(
          onWillPop: () async {
            CommonFunctions().showDialogue(
              controller.registerError,
              controller.errorText,
              controller.onLeaveRegister,
              controller.exitDialogue,
              null,
            );
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: MyAppBar(
                title: 'create account'.tr,
                leadingExists: true,
                leadingFunction: () {
                  CommonFunctions().showDialogue(
                    controller.registerError,
                    controller.errorText,
                    controller.onLeaveRegister,
                    controller.exitDialogue,
                    null,
                  );
                },
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.registerFormKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyField(
                            width: 100.w,
                            controller: controller.fullNameController,
                            hintText: 'full name'.tr,
                            isPassword: false,
                            isLast: false,
                            isName: true,
                            type: TextInputType.text,
                            prefixIcon: const Icon(
                              Icons.account_circle,
                              size: 24,
                              color: Colors.black,
                            ),
                            suffixIcon: null,
                            suffixIconFunction: null,
                            validatorFunction: CommonFunctions().validateName,
                          ),
                          const SizedBox(height: 20),
                          MyField(
                            width: 100.w,
                            controller: controller.registerEmailController,
                            hintText: 'email'.tr,
                            isPassword: false,
                            isLast: false,
                            isName: false,
                            type: TextInputType.text,
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 24,
                              color: Colors.black,
                            ),
                            suffixIcon: null,
                            suffixIconFunction: null,
                            validatorFunction: CommonFunctions().validateEmail,
                          ),
                          const SizedBox(height: 20),
                          MyField(
                            width: 100.w,
                            controller: controller.registerPasswordController,
                            hintText: 'password'.tr,
                            isPassword: true,
                            showPassword: controller.showPasswordRegister,
                            isLast: true,
                            isName: false,
                            type: TextInputType.text,
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 24,
                              color: Colors.black,
                            ),
                            suffixIcon: controller.showPasswordRegister
                                ? const Icon(
                                    CupertinoIcons.eye,
                                    size: 24,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    CupertinoIcons.eye_slash_fill,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                            suffixIconFunction:
                                controller.showPasswordFunctionRegister,
                            validatorFunction:
                                CommonFunctions().validatePassword,
                          ),
                          const SizedBox(height: 40),
                          MyButton(
                            buttonFunction: () {
                              if (controller.registerFormKey.currentState!
                                  .validate()) {
                                controller.register();
                              }
                            },
                            height: 40,
                            width: 100.w,
                            color: MyColors().mainColor,
                            child: (controller.isLoading)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      MyText(
                                        text: 'registering'.tr,
                                        size: 16,
                                        weight: FontWeight.normal,
                                        color: Colors.white,
                                        align: TextAlign.left,
                                      ),
                                    ],
                                  )
                                : MyText(
                                    text: 'register'.tr,
                                    size: 16,
                                    weight: FontWeight.normal,
                                    color: Colors.white,
                                    align: TextAlign.center,
                                  ),
                          ),
                        ],
                      ),
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
