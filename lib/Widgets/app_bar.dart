import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import 'text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool leadingExists;
  final bool actionExists;
  final VoidCallback? leadingFunction;
  final VoidCallback? actionFunction;
  final Icon? icon;

  const MyAppBar({
    super.key,
    required this.title,
    required this.leadingExists,
    this.actionExists = false,
    this.leadingFunction,
    this.actionFunction,
    this.icon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.3),
      surfaceTintColor: Colors.white,
      elevation: 1,
      titleSpacing: leadingExists ? 0 : 20,
      title: MyText(
        text: title,
        size: 22,
        weight: FontWeight.normal,
        color: Colors.black,
      ),
      leading: leadingExists
          ? IconButton(
              onPressed: leadingFunction ?? () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                size: 24,
                color: MyColors().mainColor,
              ),
            )
          : null,
      actions: actionExists
          ? [
              IconButton(
                onPressed: actionFunction!,
                icon: icon!,
              ),
            ]
          : null,
    );
  }
}
