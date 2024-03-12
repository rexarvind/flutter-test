// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AccountPage extends StatelessWidget {
//   const AccountPage({super.key, required this.user});
//   final GoogleSignInAccount user;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Welcome back'),
//       ),
//       body: SingleChildScrollView(child: Column(
//         children: [
//           CircleAvatar(
//             radius: 50,
//             backgroundImage: NetworkImage(user.photoUrl!),
//           ),
//           Text('Name: ${user.displayName!}'),
//           Text('Email: ${user.email}'),
//         ],
//       ),),
//     );
//   }
// }