import 'package:flutter/material.dart';
import 'package:online_market/models/card_models.dart';

class CustomCard extends StatefulWidget {
  final Order model;
  const CustomCard({super.key, required this.model});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late int count = widget.model.amount;
  void _decreasing() {
    setState(() {
      if (count != 0) {
        count--;
      }
    });
  }

  void _increasing() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.model.image,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model.name,
                      style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Judson'),
                    ),
                    Text(
                      widget.model.subname,
                      style: const TextStyle(
                          fontFamily: 'Judson',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff898989)),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${widget.model.price.toString()}',
                          style: const TextStyle(
                              fontSize: 27,
                              fontFamily: 'Judson',
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 110,
                          height: 31,
                          decoration: BoxDecoration(
                              color: const Color(0xffD9D9D9),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('amount:', style: TextStyle(fontSize: 15),),
                              SizedBox(width: 3,),
                              // IconButton(
                              //   onPressed: () {
                              //     _decreasing();
                              //   },
                              //   iconSize: 10,
                              //   icon: const Icon(Icons.remove),
                              // ),
                              Text(
                                count.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              // IconButton(
                              //   onPressed: () {
                              //     _increasing();
                                  
                              //   },
                              //   iconSize: 10,
                              //   icon: Icon(Icons.add),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
