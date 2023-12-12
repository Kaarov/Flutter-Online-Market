import 'package:flutter/material.dart';
import 'package:online_market/data/dummy_data.dart';
import 'package:online_market/pages/home.dart';
import 'package:online_market/pages/login.dart';
import 'package:online_market/pages/main.dart';
import 'package:online_market/pages/signup.dart';
import 'package:online_market/provider/favourite_proviser.dart';
import 'package:online_market/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Test(),
      title: 'Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ChangeNotifierProvider(create: (cxt)=> FavoriteProvider(),child: Home(products: dummyProduct),),
      routes: {
        '/': (context) => MainPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => BottomNavbar(),
      },
    );
  }
}

