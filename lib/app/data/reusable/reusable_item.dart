import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_ecommerce/app/data/model/product_model.dart';

TextStyle titleStyle() {
  return const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
}

TextStyle priceStyle() {
  return const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );
}

Widget cardProduct({required Product model, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 3,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(model.thumbnail),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: titleStyle(),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  moneyFormat(money: model.price),
                  overflow: TextOverflow.ellipsis,
                  style: priceStyle(),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(model.brand)
              ],
            ),
          )
        ],
      ),
    ),
  );
}

String moneyFormat({required num money}) {
  return NumberFormat.simpleCurrency(locale: "en_US", decimalDigits: 0)
      .format(money);
}

buildLoading() {
  Get.defaultDialog(
    title: 'Loading',
    content: const Center(
      child: CircularProgressIndicator(),
    ),
    barrierDismissible: false,
  );
}
