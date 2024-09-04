import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/home_controller.dart';
import '../Widgets/app_bar.dart';
import '../Widgets/page_entrance.dart';
import '../Widgets/text.dart';
import '../colors.dart';
import 'order_view.dart';

class FinishedOrders extends StatelessWidget {
  const FinishedOrders({
    super.key,
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
              title: 'Finished Orders',
              leadingExists: true,
            ),
            body: (controller.fetchingFinishedOrders)
                ? const Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : (controller.finishedOrders.isEmpty)
                    ? const Center(
                        child: MyText(
                          text: "There are no finished orders.",
                          size: 16,
                          weight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: controller.finishedOrders.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PageEntrance(
                              color: controller.ordersToBeDeleted.contains(
                                      controller.finishedOrders[index].orderId!)
                                  ? MyColors().mainColor
                                  : Colors.white,
                              textColor: controller.ordersToBeDeleted.contains(
                                      controller.finishedOrders[index].orderId!)
                                  ? Colors.white
                                  : Colors.black,
                              iconColor: controller.ordersToBeDeleted.contains(
                                      controller.finishedOrders[index].orderId!)
                                  ? Colors.white
                                  : MyColors().mainColor,
                              order: controller.finishedOrders[index],
                              function: () {
                                if (controller.editingOrders) {
                                  controller.selectOrder(controller
                                      .finishedOrders[index].orderId!);
                                } else {
                                  Get.to(
                                    () => OrderView(
                                      order: controller.finishedOrders[index],
                                      products: controller
                                          .finishedOrdersProducts[index],
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
          ),
        );
      },
    );
  }
}
