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
  final TextEditingController phoneController = TextEditingController(); // رقم الهاتف
  final TextEditingController departmentController = TextEditingController(); // القسم
  final TextEditingController addressController = TextEditingController(); // العنوان
  DateTime? joiningDate; // تاريخ الانضمام
  String attendanceStatus = 'Present'; // حالة الحضور الافتراضية
  
  File? _selectedImage; // الصورة المختارة

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path); // تخزين الصورة
      });
    }
  }

  // لفتح واجهة اختيار التاريخ
  Future<void> _selectJoiningDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != joiningDate) {
      setState(() {
        joiningDate = picked; // تخزين تاريخ الانضمام
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
        child: SingleChildScrollView(
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
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: departmentController,
                decoration: InputDecoration(labelText: 'Department'),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 10),
              
              // اختيار تاريخ الانضمام
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    joiningDate == null
                        ? 'Joining Date: Not selected'
                        : 'Joining Date: ${joiningDate!.toLocal()}'.split(' ')[0],
                  ),
                  ElevatedButton(
                    onPressed: () => _selectJoiningDate(context),
                    child: Text('Select Date'),
                  ),
                ],
              ),
              
              SizedBox(height: 10),

              // اختيار حالة الحضور
              DropdownButtonFormField<String>(
                value: attendanceStatus,
                items: ['Present', 'Absent', 'On Leave'].map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    attendanceStatus = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Attendance Status'),
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
                    phoneNumber: phoneController.text, // رقم الهاتف
                    department: departmentController.text, // القسم
                    address: addressController.text, // العنوان
                    joiningDate: joiningDate, // تاريخ الانضمام
                    attendanceStatus: attendanceStatus, // حالة الحضور
                    imageUrl: _selectedImage != null ? _selectedImage!.path : null, // تمرير مسار الصورة
                  );
                  Navigator.pop(context, newEmployee); // إرجاع الموظف الجديد
                },
                child: Text('Add Employee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
