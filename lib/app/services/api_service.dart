import 'package:dio/dio.dart';
import 'package:simple_ecommerce/app/data/model/product_model.dart';

class ApiServices {
  final dio = Dio();

  final baseUrl = 'https://dummyjson.com/products';

  Future<Response> readFirstUrl() async {
    var response = dio.get(baseUrl);

    return response;
  }

  Future<List<Product>> readDataLimit({required int limit}) async {
    var url = '$baseUrl?limit=$limit';
    var response = await dio.get(url);

    var daftarProduk = (response.data['products'] as List)
        .map((e) => Product.fromMap(e))
        .toList();

    return daftarProduk;
  }

  Future<List<Product>> searchProduct({required String query}) async {
    var url = '$baseUrl/search?q=$query';
    var response = await dio.get(url);

    var daftarProduk = (response.data['products'] as List)
        .map((e) => Product.fromMap(e))
        .toList();

    return daftarProduk;
  }

  Future getCategories() async {
    var url = '$baseUrl/categories';
    var response = await dio.get(url);

    var daftarProduk = response.data;

    return daftarProduk;
  }

  Future<List<Product>> searchProductByCategories(
      {required String categories}) async {
    var url = '$baseUrl/category/$categories';
    var response = await dio.get(url);

    var daftarProduk = (response.data['products'] as List)
        .map((e) => Product.fromMap(e))
        .toList();

    return daftarProduk;
  }
}
