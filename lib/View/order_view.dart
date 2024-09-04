import 'package:flutter/material.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/Widgets/informational_bit.dart';
import 'package:my_phone/Widgets/page_entrance.dart';
import 'package:get/get.dart';
import 'package:my_phone/colors.dart';
import '../Models/order.dart';
import '../Models/product.dart';
import 'order_products.dart';

class OrderView extends StatelessWidget {
  final MyOrder order;
  final List<Product> products;
  const OrderView({
    super.key,
    required this.order,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const MyAppBar(
          title: 'Order',
          leadingExists: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                InformationalBit(
                  dataPoint: 'Order ID',
                  information: order.orderId!,
                ),
                const SizedBox(height: 20),
                InformationalBit(
                  dataPoint: 'Recipient Name',
                  information: order.recipientFullName!,
                ),
                const SizedBox(height: 20),
                InformationalBit(
                  dataPoint: 'Recipient Number',
                  information: order.phoneNumber!,
                ),
                const SizedBox(height: 20),
                InformationalBit(
                  dataPoint: 'Governorate',
                  information: order.governorate!,
                ),
                const SizedBox(height: 20),
                InformationalBit(
                  dataPoint: 'Closest Known Point',
                  information: order.closestKnownPoint!,
                ),
                const SizedBox(height: 20),
                InformationalBit(
                  dataPoint: 'Status',
                  information: order.status!,
                ),
                const SizedBox(height: 20),
                InformationalBit(
                  dataPoint: 'Date Ordered',
                  information: order.date!,
                ),
                const SizedBox(height: 20),
                InformationalBit(
                  dataPoint: 'Total Price',
                  information: '\$${order.totalPrice!}',
                ),
                PageEntrance(
                  color: Colors.white,
                  textColor: Colors.black,
                  iconColor: MyColors().mainColor,
                  order: order,
                  name: 'Order Products',
                  function: () {
                    Get.to(() => OrderProducts(products: products));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
