import 'package:assignment/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mobile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        children: [
          ProductWidget(imgSrc: 'https://m.media-amazon.com/images/I/619oqSJVY5L._SX679_.jpg', productName: 'iPhone 16 Pro Max'),
          ProductWidget(
              imgSrc: 'https://m.media-amazon.com/images/I/31Sm7rY5XxL._SY445_SX342_QL70_FMwebp_.jpg',
              productName: 'iPhone 16 Plus'),
          ProductWidget(
              imgSrc: 'https://m.media-amazon.com/images/I/31AUcMGV1jL._SY445_SX342_QL70_FMwebp_.jpg', productName: 'iPhone SE'),
          ProductWidget(
              imgSrc: 'https://m.media-amazon.com/images/I/21ZzpnTMVjL._SX300_SY300_QL70_FMwebp_.jpg',
              productName: 'iPhone Silicon Case'),
          ProductWidget(imgSrc: 'https://m.media-amazon.com/images/I/41sXFsE+OcL._SY300_SX300_.jpg', productName: 'Redmi 13C'),
        ],
      ),
    );
  }
}
