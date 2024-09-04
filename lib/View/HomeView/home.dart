import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            onPageChanged: controller.changePage,
            children: controller.pageViewItems,
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            onTap: controller.changePage,
            currentIndex: controller.currentIndex,
            items: controller.navigationBarItems,
            selectedLabelStyle: GoogleFonts.rubik(
              color: MyColors().mainColor,
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelStyle: GoogleFonts.rubik(
              color: MyColors().mainColor,
              fontWeight: FontWeight.normal,
            ),
            selectedItemColor: MyColors().mainColor,
            unselectedItemColor: MyColors().mainColor,
          ),
        ),
      ),
    );
  }
}
