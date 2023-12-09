import 'package:online_market/pages/my_cart.dart';
import 'package:online_market/pages/profile_page.dart';
import 'package:online_market/resources/resources.dart';
import 'package:online_market/widgets/profile_info.dart';
import 'package:online_market/widgets/row_widget.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 40),
          child: Column(
            children: [
              const InfoProfile(), // Profile card
              const SizedBox(
                height: 49,
              ),
              Container(
                // Container that consists rows
                height: 445,
                width: 320,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black12),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
                  child: Column(children: [
                    RowWidget(
                      photo: Images.user,
                      title: 'Personal Details',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                    ),
                    // RowWidget(
                    //   photo: Images.purse,
                    //   title: 'My Order',
                    //   onTap: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=> MyOrders()));
                    //   },
                    // ),
                    RowWidget(
                        photo: Images.love,
                        title: 'My Favourites',
                        onTap: () {}),
                    RowWidget(
                      photo: Images.shoppingCart,
                      title: 'My Card',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyCard()));
                      },
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
