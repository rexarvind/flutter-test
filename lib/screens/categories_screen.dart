import 'package:flutter/material.dart';

import '../widgets/my_bottom_app_bar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: const SingleChildScrollView(
        child: Center(child: Text('Categories Page')),
      ),
    );
  }
}
