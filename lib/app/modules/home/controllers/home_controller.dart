import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ecommerce/app/data/model/product_model.dart';
import 'package:simple_ecommerce/app/data/reusable/reusable_item.dart';
import 'package:simple_ecommerce/app/services/api_service.dart';

class HomeController extends GetxController with StateMixin<List<Product>> {
  final apiService = ApiServices();
  final scrollController = ScrollController();

  RxList<Product> daftarProduk = RxList.empty();
  List<String> category = [
    "smartphones",
    "laptops",
    "fragrances",
    "skincare",
    "groceries",
    "home-decoration",
    "furniture",
    "tops",
    "womens-dresses",
    "womens-shoes",
    "mens-shirts",
    "mens-shoes",
    "mens-watches",
    "womens-watches",
    "womens-bags",
    "womens-jewellery",
    "sunglasses",
    "automotive",
    "motorcycle",
    "lighting"
  ];

  var selectedCategory = Rxn<String>();
  var limit = 10.obs;

  Future pickCategory({required String category}) async {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;
      buildLoading();
      var hasil =
          await apiService.searchProductByCategories(categories: category);
      daftarProduk.value = hasil;
      Get.until((route) => !(Get.isDialogOpen!));
    } else {
      selectedCategory.value = null;
      buildLoading();
      var hasil = await apiService.readDataLimit(limit: limit.value);
      daftarProduk.value = hasil;
      Get.until((route) => !(Get.isDialogOpen!));
    }
  }

  @override
  void onInit() {
    apiService.readDataLimit(limit: limit.value).then((value) {
      daftarProduk.value = value;
      change(value, status: RxStatus.success());
    });

    scrollController.addListener(
      () async {
        if (selectedCategory.value == null) {
          if (scrollController.position.maxScrollExtent ==
              scrollController.offset) {
            limit.value += 10;
            var newData = await apiService.readDataLimit(limit: limit.value);
            daftarProduk.value = newData;
          }
        }
      },
    );

    super.onInit();
  }
}
