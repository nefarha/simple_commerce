import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:simple_ecommerce/app/data/reusable/reusable_item.dart';

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
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: buildProductView(),
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
