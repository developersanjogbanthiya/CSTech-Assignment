import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({super.key, required this.imgSrc, required this.productName});
  String imgSrc;
  String productName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          Image.network(imgSrc),
          Gap(12),
          Text(
            productName,
          ),
        ],
      ),
    );
  }
}
