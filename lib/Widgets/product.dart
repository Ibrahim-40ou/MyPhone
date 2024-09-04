import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_phone/Widgets/button.dart';
import 'package:my_phone/Widgets/text.dart';
import 'package:my_phone/colors.dart';
import 'package:sizer/sizer.dart';
import '../Models/product.dart';
import 'package:get/get.dart';

import '../View/product_view.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: MyButton(
        buttonFunction: () {
          Get.to(() => ProductView(product: product));
        },
        height: 100,
        width: 100.w,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: product.image!,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: product.name!,
                    size: 16,
                    weight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  MyText(
                    text:
                        '${(product.memory != null) ? '${product.memory} ' : ''}${product.color}',
                    size: 14,
                    weight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  MyText(
                    text: '\$${product.price!}',
                    size: 14,
                    weight: FontWeight.normal,
                    color: MyColors().mainColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
