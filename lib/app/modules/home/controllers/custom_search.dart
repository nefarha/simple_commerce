import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ecommerce/app/data/model/product_model.dart';
import 'package:simple_ecommerce/app/data/reusable/reusable_item.dart';
import 'package:simple_ecommerce/app/services/api_service.dart';

class CustomSearchButton extends SearchDelegate {
  CustomSearchButton() : super();

  final apiService = ApiServices();
  RxList<Product> daftarProduk = RxList.empty();

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () async {
          buildLoading();
          daftarProduk.value = await apiService.searchProduct(query: query);
          Get.until((route) => !Get.isDialogOpen!);
        },
        icon: const Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return (daftarProduk.isNotEmpty)
        ? Obx(
            () => Column(
              children: [
                ...daftarProduk.map(
                  (model) => ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(model.thumbnail),
                    ),
                    title: Text(model.title),
                    subtitle: Text(model.category),
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: Text("Data tidak ditemukan"),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return (daftarProduk.isNotEmpty)
        ? Obx(
            () => Column(
              children: [
                ...daftarProduk.map(
                  (model) => ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(model.thumbnail),
                    ),
                    title: Text(model.title),
                    subtitle: Text(model.category),
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: Text("Data tidak ditemukan"),
          );
  }
}
