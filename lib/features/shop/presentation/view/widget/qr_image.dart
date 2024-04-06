import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatelessWidget {
  const QRImage(this.price, {super.key});

  final String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: QrImageView(
                data:
                    'https://payment-api.yimplatform.com/checkout?price=${price}',
                version: QrVersions.auto,
                size: 350),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'Scan and Pay',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            'Price : $price',
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
