import 'package:flutter/material.dart';

class TaskTimerPage extends StatelessWidget {
  const TaskTimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Timer'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Timer Here'),
              Text('List here'),
            ],
          ),
        ),
      ),
    );
  }
}
