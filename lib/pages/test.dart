// import 'package:flutter/material.dart';
// import 'package:online_market/services/api_service.dart';

// class Test extends StatefulWidget {
//   Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   final ApiService _apiService = ApiService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: 
//       Center(
        
      
//         child: Column(mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.deepPurple 
//             ),
            
//             onPressed: () async {
//             await _apiService.get_card();
//           }, child: Text('djshd'))
//         ]),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:online_market/models/card_models.dart';
import 'package:online_market/widgets/custom_card.dart';

class CustomCardListView extends StatelessWidget {
  final List<Order> orders;

  const CustomCardListView({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return CustomCard(model: orders[index]);
      },
    );
  }
}