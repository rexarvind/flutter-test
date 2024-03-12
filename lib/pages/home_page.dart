// import 'package:flutter/material.dart';

// // import '../screens/settings_screen.dart';
// import './notes/notes_page.dart';
// import './auth_page.dart';
// import './settings_page.dart';
// import '../notes/notes_home_page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   static const routeName = '/';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Demo App'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             const UserAccountsDrawerHeader(
//               accountName: Text('User Name'),
//               accountEmail: Text('text@example.com'),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: NetworkImage('https://dummyimage.com/300'),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 image: DecorationImage(
//                   image: NetworkImage('https://dummyimage.com/360x270'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               otherAccountsPictures: [
//                 CircleAvatar(
//                   backgroundColor: Colors.white,
//                   backgroundImage: NetworkImage('https://dummyimage.com/90'),
//                 )
//               ],
//             ),
//             ListTile(
//               title: const Text('Notes'),
//               leading: const Icon(Icons.sticky_note_2_sharp),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (ctx) => const NotesPage()),
//                 );
//               },
//             ),
//             ListTile(
//               title: const Text('Notes 2'),
//               leading: const Icon(Icons.sticky_note_2_sharp),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.restorablePushNamed(context, NotesHomePage.routeName);
//               },
//             ),
//             ListTile(
//               title: const Text('Task Timer'),
//               leading: const Icon(Icons.timer_rounded),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('My Account'),
//               leading: const Icon(Icons.person),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.restorablePushNamed(context, SettingsPage.routeName);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.login),
//               title: const Text('Login'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.restorablePushNamed(context, AuthPage.routeName);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//       body: const Center(
//         child: Text('Hello World!'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         tooltip: 'Shop',
//         child: const Icon(Icons.shop),
//         onPressed: () {},
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }
