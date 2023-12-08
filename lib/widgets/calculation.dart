
import 'package:flutter/material.dart';

class Calculation extends StatelessWidget {
  final String title;
  final String price;
  const Calculation({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Judson',
                color: Colors.black),
          ),
          Spacer(),
          Text(
            price,
            style: TextStyle(
                fontFamily: 'Judson',
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
