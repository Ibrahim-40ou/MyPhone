import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/Models/product.dart';
import 'package:my_phone/View/product_view.dart';
import 'package:my_phone/Widgets/button.dart';
import 'package:my_phone/Widgets/text.dart';
import 'package:my_phone/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class CartItem extends StatelessWidget {
  final Product item;
  final HomeController controller = Get.find();
  CartItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: MyButton(
        height: 140,
        width: 100.w,
        buttonFunction: () {
          if (controller.editingCart) {
            controller.selectItem(item.productId!);
            return;
          } else {
            Get.to(ProductView(product: item));
          }
        },
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              height: 140,
              width: 40.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: item.image!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: MyColors().myBlue,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: MyColors().myRed,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: item.name!,
                        size: 16,
                        weight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      MyText(
                        text:
                            '${(item.memory != null) ? '${item.memory} ' : ''}${item.color}',
                        size: 14,
                        weight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      MyText(
                        text: '\$${item.price}',
                        size: 14,
                        weight: FontWeight.normal,
                        color: MyColors().mainColor,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 45,
                        width: 30.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors().secondaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.changeQuantityInCart(item, false);
                              },
                              icon: const Icon(
                                Icons.remove,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                            MyText(
                              text: '${item.quantityInCart!}',
                              size: 18,
                              weight: FontWeight.normal,
                              color: Colors.black,
                            ),
                            IconButton(
                              onPressed: () {
                                controller.changeQuantityInCart(item, true);
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      (controller.editingCart)
                          ? Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: controller.toBeDeleted
                                          .contains(item.productId!)
                                      ? MyColors().mainColor
                                      : Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
