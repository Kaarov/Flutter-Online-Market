
import 'package:online_market/resources/resources.dart';
import 'package:flutter/material.dart';

class InfoProfile extends StatelessWidget {
  const InfoProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset(
                Images.profilePhoto,
                height: 80,
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sam Man',
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w400,
                    fontFamily: 'Judson'),
              ),
              Text(
                'sam.man@gmail.com',
                style: TextStyle(
                  fontFamily: 'Judson',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black12),
              )
            ],
          ),
        ],
      ),
    );
  }
}


