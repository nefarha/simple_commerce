import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:simple_ecommerce/app/data/reusable/reusable_item.dart';
import 'package:simple_ecommerce/app/modules/home/controllers/custom_search.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchButton());
            },
            icon: const Icon(Icons.search),
          ),
        ],
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...controller.category.map(
                      (data) => Obx(
                        () => GestureDetector(
                          onTap: () async {
                            await controller.pickCategory(category: data);
                          },
                          child: Card(
                            color: controller.selectedCategory.value == data
                                ? Colors.orange
                                : null,
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data,
                                style: TextStyle(
                                    color: controller.selectedCategory.value ==
                                            data
                                        ? Colors.white
                                        : null),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: buildProductView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductView() {
    return Obx(
      () => MasonryGridView.builder(
        controller: controller.scrollController,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        mainAxisSpacing: 5,
        crossAxisSpacing: 3,
        itemCount: controller.daftarProduk.length,
        itemBuilder: (context, index) {
          var model = controller.daftarProduk[index];
          return cardProduct(model: model);
        },
      ),
    );
  }
}
