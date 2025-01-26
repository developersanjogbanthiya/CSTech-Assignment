import 'package:flutter/material.dart';

class KycPage extends StatelessWidget {
  const KycPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KYC Page'),
      ),
      body: Center(
        child: Text('This is KYC Page'),
      ),
    );
  }
}
