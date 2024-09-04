import 'package:flutter/material.dart';
import 'package:my_phone/Models/order.dart';
import 'package:my_phone/Widgets/text.dart';
import 'package:sizer/sizer.dart';
import 'button.dart';

class PageEntrance extends StatelessWidget {
  final MyOrder order;
  final String name;
  final Function function;
  final Color color;
  final Color textColor;
  final Color iconColor;
  const PageEntrance({
    super.key,
    required this.order,
    this.name = '',
    required this.function,
    required this.color,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: MyButton(
        buttonFunction: () {
          function();
        },
        height: 60,
        width: 100.w,
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(
                text: name.isNotEmpty ? name : order.date!,
                size: 18,
                weight: FontWeight.normal,
                color: textColor,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
