import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:system/models.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? _selectedImage; // الصورة المختارة

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path); // تخزين الصورة
      });
    }
  }

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
            // اختيار صورة الموظف
            GestureDetector(
              onTap: _pickImage, // فتح معرض الصور
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _selectedImage != null
                    ? Image.file(_selectedImage!, fit: BoxFit.cover)
                    : Center(child: Text('Select Image')),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // إنشاء موظف جديد مع الصورة
                final newEmployee = Employee(
                  name: nameController.text,
                  position: positionController.text,
                  email: emailController.text,
                  imageUrl: _selectedImage != null ? _selectedImage!.path : null, // تمرير مسار الصورة
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
