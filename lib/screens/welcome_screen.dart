import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/welcome_controller.dart';
import '../controllers/auth_controller.dart';
import '../screens/notes_screen.dart';
import '../screens/account_screen.dart';
import '../screens/auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final welcomeController = Get.put(WelcomeController());
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Demo App'),
        ),
        body: const SingleChildScrollView(
          child: Text(''),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                    _authController.isLoggedIn.value ? 'Welcome' : 'Guest'),
                accountEmail: Text(
                    _authController.isLoggedIn.value ? 'text@example.com' : ''),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(_authController.isLoggedIn.value
                      ? ''
                      : 'https://dummyimage.com/300'),
                ),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage('https://dummyimage.com/360x270'),
                    fit: BoxFit.cover,
                  ),
                ),
                // otherAccountsPictures: [
                //   CircleAvatar(
                //     backgroundColor: Colors.white,
                //     backgroundImage: NetworkImage('https://dummyimage.com/90'),
                //   )
                // ],
              ),
              ListTile(
                title: const Text('Notes'),
                leading: const Icon(Icons.sticky_note_2_sharp),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(
                    () => NotesScreen(),
                    preventDuplicates: true,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('My Account'),
                leading: const Icon(Icons.person),
                onTap: () {
                  Navigator.pop(context);
                  if (_authController.isLoggedIn.value) {
                    Get.to(
                      () => AccountScreen(),
                      preventDuplicates: true,
                    );
                  } else {
                    Get.to(
                      () => AuthScreen(),
                      preventDuplicates: true,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 60.0,
          padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {},
                iconSize: 30.0,
                tooltip: 'Home',
                icon: const Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {},
                iconSize: 30.0,
                tooltip: 'Categories',
                icon: const Icon(Icons.category),
              ),
              const SizedBox(width: 10),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Get.to(
                    () => NotesScreen(),
                    preventDuplicates: true,
                  );
                },
                iconSize: 30.0,
                tooltip: 'Notes',
                icon: const Icon(Icons.sticky_note_2_sharp),
              ),
              IconButton(
                onPressed: () {
                  if (_authController.isLoggedIn.value) {
                    Get.to(
                      () => AccountScreen(),
                      preventDuplicates: true,
                    );
                  } else {
                    Get.to(
                      () => AuthScreen(),
                      preventDuplicates: true,
                    );
                  }
                },
                iconSize: 30.0,
                tooltip: 'Account',
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          tooltip: 'Cart',
          child: const Icon(Icons.shopping_cart),
        ),
      );
    });
  }
}
