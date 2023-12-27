import 'package:get/get.dart';
import 'package:simple_ecommerce/app/data/model/product_model.dart';

class DetailProdukController extends GetxController {
  Product dataProduk = Get.arguments!;

  var isExpanded = false.obs;
}
