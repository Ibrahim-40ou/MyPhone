import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/View/order_view.dart';
import 'package:my_phone/Widgets/app_bar.dart';
import 'package:my_phone/Widgets/page_entrance.dart';
import 'package:my_phone/Widgets/text.dart';
import 'package:my_phone/colors.dart';
import 'package:my_phone/common_functions.dart';

class PendingOrders extends StatelessWidget {
  const PendingOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (controller.editingOrders) {
              CommonFunctions().showDialogue(
                false,
                '',
                () {
                  controller.cancelOrdersEdit();
                  Get.back();
                },
                null,
                'Are you sure you want to cancel editing? Selected orders will be unselected.',
              );
            } else {
              Get.back();
            }
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: MyAppBar(
                title: 'Pending Orders',
                leadingExists: true,
                leadingFunction: () {
                  if (controller.editingOrders) {
                    CommonFunctions().showDialogue(
                      false,
                      '',
                      () {
                        controller.cancelOrdersEdit();
                        Get.back();
                      },
                      null,
                      'Are you sure you want to cancel editing? Selected orders will be unselected.',
                    );
                  } else {
                    Get.back();
                  }
                },
                actionExists:
                    (controller.pendingOrders.isNotEmpty) ? true : false,
                actionFunction: () {
                  if (controller.editingOrders) {
                    CommonFunctions().showDialogue(
                      false,
                      '',
                      () {
                        controller.deleteOrder();
                        Get.back();
                      },
                      null,
                      'Deleting pending orders will not get them processed and will be lost. Continue?',
                    );
                  } else {
                    controller.editOrders();
                  }
                },
                icon: controller.editingOrders
                    ? const Icon(
                        Icons.delete,
                        size: 24,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.edit,
                        size: 24,
                        color: Colors.black,
                      ),
              ),
              body: (controller.fetchingPendingOrders)
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
                  : (controller.pendingOrders.isEmpty)
                      ? const Center(
                          child: MyText(
                            text: 'You have no pending orders.',
                            size: 16,
                            weight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            itemCount: controller.pendingOrders.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PageEntrance(
                                color: controller.ordersToBeDeleted.contains(
                                        controller
                                            .pendingOrders[index].orderId!)
                                    ? MyColors().mainColor
                                    : Colors.white,
                                textColor: controller.ordersToBeDeleted
                                        .contains(controller
                                            .pendingOrders[index].orderId!)
                                    ? Colors.white
                                    : Colors.black,
                                iconColor: controller.ordersToBeDeleted
                                        .contains(controller
                                            .pendingOrders[index].orderId!)
                                    ? Colors.white
                                    : MyColors().mainColor,
                                order: controller.pendingOrders[index],
                                function: () {
                                  if (controller.editingOrders) {
                                    controller.selectOrder(controller
                                        .pendingOrders[index].orderId!);
                                  } else {
                                    Get.to(
                                      () => OrderView(
                                        order: controller.pendingOrders[index],
                                        products: controller
                                            .pendingOrdersProducts[index],
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
            ),
          ),
        );
      },
    );
  }
}
