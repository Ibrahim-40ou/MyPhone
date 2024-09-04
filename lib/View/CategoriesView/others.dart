import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/Widgets/text.dart';

class Others extends StatelessWidget {
  const Others({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return const SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: MyAppBar(
              title: 'Other Products',
              leadingExists: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: MyText(
                      text: 'Nothing Here.',
                      size: 16,
                      weight: FontWeight.normal,
                      color: Colors.black,
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
