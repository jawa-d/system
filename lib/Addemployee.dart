import 'package:flutter/material.dart';
import 'package:system/models.dart';

class AddEmployee extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // إنشاء موظف جديد
                final newEmployee = Employee(
                  name: nameController.text,
                  position: positionController.text,
                  email: emailController.text,
                );
                Navigator.pop(context, newEmployee); // إرجاع الموظف الجديد
              },
              child: Text('Add Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
