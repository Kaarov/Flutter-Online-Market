
import 'package:flutter/material.dart';

class My_Orders extends StatelessWidget {
  const My_Orders({
    super.key,
    required List<Widget> crosses,
  }) : _crosses = crosses;

  final List<Widget> _crosses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        height: MediaQuery.of(context).size.height*0.7,
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '28.10.2023',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>const  Padding(
                  padding:  EdgeInsets.symmetric(vertical: 7),
                  // child: CustomCardBaizak(model: ,),
                ),
                itemCount: _crosses.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}