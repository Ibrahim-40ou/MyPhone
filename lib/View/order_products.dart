import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/Widgets/product.dart';

import '../Models/product.dart';

class OrderProducts extends StatelessWidget {
  final List<Product> products;
  const OrderProducts({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: const MyAppBar(
              title: 'Order Products',
              leadingExists: true,
            ),
            body: ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
