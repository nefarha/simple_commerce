import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ecommerce/app/data/model/product_model.dart';
import 'package:simple_ecommerce/app/services/api_service.dart';

class HomeController extends GetxController with StateMixin<List<Product>> {
  final apiService = ApiServices();
  final scrollController = ScrollController();

  RxList<Product> daftarProduk = RxList.empty();

  @override
  void onInit() {
    apiService.readDataLimit().then((value) {
      daftarProduk.value = value;
      change(value, status: RxStatus.success());
    });

    super.onInit();
  }
}
