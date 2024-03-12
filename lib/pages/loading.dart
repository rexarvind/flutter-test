// import 'package:demo_app/models/api_response.dart';
// import 'package:demo_app/notes/notes_home_page.dart';
// import 'package:demo_app/services/user_service.dart';
// import 'package:flutter/material.dart';

// import '../pages/auth_page.dart';

// class Loading extends StatefulWidget {
//   const Loading({super.key});
//   static const routeName = '/loading';

//   @override
//   State<Loading> createState() => _LoadingState();
// }

// class _LoadingState extends State<Loading> {
//   void _loadUserInfo() async {
//     String token = await getToken();
//     if (token.isEmpty) {
//       if (!context.mounted) return;
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (BuildContext context) => const AuthPage(),
//         ),
//         (route) => false,
//       );
//     } else {
//       ApiResponse response = await getUserDetail();
//       if (response.error == null) {
//         if (!context.mounted) return;
//         Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(
//             builder: (BuildContext context) => const NotesHomePage(),
//           ),
//           (route) => false,
//         );
//       } else if (response.error == 'Unauth') {
//         if (!context.mounted) return;
//         Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(
//             builder: (BuildContext context) => const AuthPage(),
//           ),
//           (route) => false,
//         );
//       } else {
//         if (!context.mounted) return;
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('${response.error}'),
//         ));
//       }
//     }
//   }

//   @override
//   void initState() {
//     _loadUserInfo();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
