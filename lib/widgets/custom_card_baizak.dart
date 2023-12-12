import 'package:flutter/material.dart';
import 'package:online_market/models/card_models.dart';

class CustomCardBaizak extends StatefulWidget {
  final Order model;
  const CustomCardBaizak({super.key, required this.model});

  @override
  State<CustomCardBaizak> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCardBaizak> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 130,
        width: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.model.image,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Judson'),
                    ),
                    Text(
                      widget.model.subname,
                      style: const TextStyle(
                          fontFamily: 'Judson',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff898989)),
                    ),
                    Text(
                      'quantity: ${widget.model.amount}',
                      style: const TextStyle(
                          fontFamily: 'Judson',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff898989)),
                    ),
                    // const SizedBox(
                    //   height: 0,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        '\$${widget.model.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Judson',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 14,
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
