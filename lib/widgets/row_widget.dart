import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  final String title;
  final String photo;
  final Function() onTap;

  const RowWidget({super.key, required this.photo, required this.title, required
  this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 65,
          child: Column(
            children: [
              SizedBox(
                height: 65,
                child: Row(children: [
                  Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12),
                      child: Image.asset(
                        photo,
                        height: 50,
                        width: 50,
                      )),
                  const SizedBox(
                    width: 11,
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 19.5, fontWeight: FontWeight.w300, fontFamily: 'Judson'),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  const SizedBox(
                    height: 35,
                    width: 15,
                    child: Icon(
                      Icons.navigate_next,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
