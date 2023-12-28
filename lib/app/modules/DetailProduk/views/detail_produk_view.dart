import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ecommerce/app/data/reusable/reusable_item.dart';

import '../controllers/detail_produk_controller.dart';

class DetailProdukView extends GetView<DetailProdukController> {
  const DetailProdukView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shopImage(),
            shopTitle(),
            shopDescription(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget shopImage() {
    return SizedBox(
      height: 250,
      width: Get.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        child: controller.dataProduk.images.isNotEmpty
            ? Row(
                children: List.generate(
                  controller.dataProduk.images.length,
                  (index) => Container(
                    height: Get.height,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          controller.dataProduk.images[index],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: Get.height,
                width: Get.width,
                color: Colors.blue,
              ),
      ),
    );
  }

  Widget shopTitle() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.dataProduk.title,
              overflow: TextOverflow.ellipsis,
              style: headerStyle(),
            ),
            Row(
              children: [
                Text(moneyFormat(money: controller.dataProduk.price)),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Text("${controller.dataProduk.stock} stock remaining"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(
                  Icons.star,
                  color: greyColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${controller.dataProduk.rating}',
                  style: const TextStyle(color: greyColor),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: greyColor,
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              title: Text(controller.dataProduk.brand),
            ),
          ],
        ),
      ),
    );
  }

  Widget shopDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: headerStyle(),
            overflow: TextOverflow.ellipsis,
          ),
          Column(
            children: [
              Obx(
                () => Text(
                  'Ini hanya sebuah description ' * 20,
                  textAlign: TextAlign.justify,
                  maxLines: controller.isExpanded.value ? null : 4,
                ),
              ),
              TextButton(
                onPressed: () {
                  controller.isExpanded.toggle();
                },
                child: Obx(() => Text(
                      controller.isExpanded.value
                          ? 'sembunyikan'
                          : 'lihat semua',
                      style: const TextStyle(
                        color: Colors.orange,
                      ),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
