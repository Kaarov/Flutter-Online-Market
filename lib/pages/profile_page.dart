import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_market/pages/main.dart';
import 'package:online_market/services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_profile();
  
  }

  Future<void> get_profile() async {
    ApiService _apiService = ApiService();
    Map<String, dynamic> profile = await _apiService.getProfile();
    name = profile['username'];
    email = profile['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 90),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/pngs/profilePhoto.png'),
            ),
            const SizedBox(height: 120),
            itemProfile("Name", '${name}', CupertinoIcons.person),
            const SizedBox(height: 30),
          
            itemProfile("Email", '${email}', CupertinoIcons.mail),
            const SizedBox(height: 20),
           
            const SizedBox(height: 150),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
                }, 
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text('Log out')
              ),
            )

          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10
          )
        ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}