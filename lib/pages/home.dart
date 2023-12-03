import 'package:flutter/material.dart';
import 'package:online_market/main.dart';

int _balance = 0;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ATM',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('Username'),
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            Container(
                height: 40,
                width: 200,
                child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Deposit'),
                          content: TextField(
                            onChanged: (String value) {
                              _balance = int.parse(value);
                            },
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                });

                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Deposit'),
                )),
            Padding(padding: EdgeInsets.only(top: 50)),
            Container(
                height: 40,
                width: 200,
                child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Withdraw'),
                          content: TextField(
                            onChanged: (String value) {
                              _balance = int.parse(value);
                            },
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                });

                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Withdraw'),
                )),
          ],
        ),
      ),
    );
  }
}
