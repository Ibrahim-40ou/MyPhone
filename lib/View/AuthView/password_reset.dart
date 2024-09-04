import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/common_functions.dart';
import 'package:sizer/sizer.dart';
import '../../Controllers/auth_controller.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text.dart';
import '../../Widgets/text_form_field.dart';
import '../../colors.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        if (controller.passwordResetError) {
          Future.microtask(
            () => CommonFunctions().showDialogue(
              controller.passwordResetError,
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
              controller.passwordResetError,
              controller.errorText,
              controller.onLeavePasswordReset,
              controller.exitDialogue,
              null,
            );
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: MyAppBar(
                title: 'password reset'.tr,
                leadingExists: true,
                leadingFunction: () {
                  CommonFunctions().showDialogue(
                    controller.passwordResetError,
                    controller.errorText,
                    controller.onLeavePasswordReset,
                    controller.exitDialogue,
                    null,
                  );
                },
              ),
              body: Form(
                key: controller.resetPasswordFormKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            text:
                                'we will send a password reset link to the email you enter'
                                    .tr,
                            size: 22,
                            weight: FontWeight.normal,
                            color: Colors.black,
                            align: TextAlign.center,
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(height: 20),
                          MyField(
                            width: 100.w,
                            controller: controller.resetPasswordController,
                            hintText: 'email'.tr,
                            isPassword: false,
                            isLast: true,
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
                          const SizedBox(height: 40),
                          MyButton(
                            buttonFunction: () {
                              if (controller.resetPasswordFormKey.currentState!
                                  .validate()) {
                                controller.resetPassword();
                              }
                            },
                            height: 40,
                            width: 100.w,
                            color: MyColors().mainColor,
                            disabled: controller.isLoading,
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
                                        text: 'sending'.tr,
                                        size: 16,
                                        weight: FontWeight.normal,
                                        color: Colors.white,
                                        align: TextAlign.left,
                                      ),
                                    ],
                                  )
                                : MyText(
                                    text: 'send'.tr,
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
