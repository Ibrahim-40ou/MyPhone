import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_phone/Controllers/home_controller.dart';
import 'package:my_phone/Widgets/product.dart';
import 'package:my_phone/Widgets/search_bar.dart';
import 'package:my_phone/Widgets/text.dart';

import '../colors.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            controller.clearSearch();
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: MySearchBar(controller: controller.searchController),
              body: (controller.searchingProducts)
                  ? Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: MyColors().myBlue,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : (controller.searchResult.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.builder(
                            itemCount: controller.searchResult.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProductCard(
                                product: controller.searchResult[index],
                              );
                            },
                          ),
                        )
                      : (controller.searchController.text.isNotEmpty)
                          ? const Center(
                              child: MyText(
                                text: 'No results found.',
                                size: 16,
                                weight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            )
                          : const Center(
                              child: MyText(
                                text: 'Search something to find here.',
                                size: 16,
                                weight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
            ),
          ),
        );
      },
    );
  }
}
