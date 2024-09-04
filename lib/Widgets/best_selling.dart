import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_phone/Widgets/text.dart';
import 'package:sizer/sizer.dart';
import '../Models/product.dart';
import '../View/product_view.dart';
import '../colors.dart';
import 'button.dart';
import 'package:get/get.dart';

class BestSelling extends StatelessWidget {
  final Product product;
  const BestSelling({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonFunction: () {
        Get.to(() => ProductView(product: product));
      },
      height: 252,
      width: (100.w - 32) / 2,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
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
          const SizedBox(height: 5),
          MyText(
            text: product.name!,
            size: 16,
            weight: FontWeight.w500,
            color: MyColors().mainColor,
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
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
