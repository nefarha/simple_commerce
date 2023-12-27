import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ecommerce/app/data/model/product_model.dart';
import 'package:simple_ecommerce/app/services/api_service.dart';

class HomeController extends GetxController with StateMixin<List<Product>> {
  final apiService = ApiServices();
  final scrollController = ScrollController();

  RxList<Product> daftarProduk = RxList.empty();

  var limit = 10.obs;

  @override
  void onInit() {
    apiService.readDataLimit(limit: limit.value).then((value) {
      daftarProduk.value = value;
      change(value, status: RxStatus.success());
    });

    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          limit.value += 10;
          var newData = await apiService.readDataLimit(limit: limit.value);
          daftarProduk.value = newData;
        }
      },
    );

    super.onInit();
  }
}
