import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_phone/View/filter_and_sort.dart';
import 'package:sizer/sizer.dart';
import '../Controllers/home_controller.dart';
import '../colors.dart';

class MySearchBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeController homeController = Get.find();

  final TextEditingController controller;
  MySearchBar({
    super.key,
    required this.controller,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          homeController.clearSearch();
        },
        icon: Icon(
          Icons.arrow_back,
          size: 24,
          color: MyColors().mainColor,
        ),
      ),
      title: SizedBox(
        width: 100.w,
        child: TextFormField(
          textInputAction: TextInputAction.search,
          controller: controller,
          onFieldSubmitted: (value) {
            homeController.searchProducts();
          },
          style: GoogleFonts.rubik(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hintText: 'Search',
            hintStyle: GoogleFonts.rubik(
              color: Colors.grey,
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.search,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const FilterAndSort());
          },
          icon: Image.asset(
            'assets/filter.png',
            height: 24,
            width: 24,
          ),
        )
      ],
    );
  }
}
