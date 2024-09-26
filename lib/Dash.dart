import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:system/Addemployee.dart';
import 'package:system/Employeelist.dart';
import 'package:system/models.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Employee> employees = []; // قائمة الموظفين
  int totalHoursWorked = 0; // عدد ساعات العمل اليومية

  void _addEmployee(Employee employee) {
    setState(() {
      employees.add(employee);
    });
  }

  void _deleteEmployee(Employee employee) {
    setState(() {
      employees.remove(employee);
    });
  }

  void _editEmployee(Employee oldEmployee, Employee newEmployee) {
    setState(() {
      final index = employees.indexOf(oldEmployee);
      if (index != -1) {
        employees[index] = newEmployee;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Total Employees: ${employees.length}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Daily Hours Worked: $totalHoursWorked',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final newEmployee = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEmployee(),
                      ),
                    );
                    if (newEmployee != null) {
                      _addEmployee(newEmployee); // إضافة الموظف الجديد
                    }
                  },
                  child: Text('Add Employee'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeList(
                          employees: employees,
                          onDelete: _deleteEmployee,
                          onEdit: (oldEmployee) async {
                            final updatedEmployee = await showDialog<Employee>(
                              context: context,
                              builder: (context) => EditEmployeeDialog(oldEmployee: oldEmployee),
                            );
                            if (updatedEmployee != null) {
                              _editEmployee(oldEmployee, updatedEmployee);
                            }
                          },
                        ),
                      ),
                    );
                  },
                  child: Text('View Employees'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Dialog لتعديل بيانات الموظف
class EditEmployeeDialog extends StatefulWidget {
  final Employee oldEmployee;

  EditEmployeeDialog({Key? key, required this.oldEmployee}) : super(key: key);

  @override
  _EditEmployeeDialogState createState() => _EditEmployeeDialogState();
}

class _EditEmployeeDialogState extends State<EditEmployeeDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(); // رقم الهاتف
  final TextEditingController departmentController = TextEditingController(); // القسم
  final TextEditingController addressController = TextEditingController(); // العنوان
  DateTime? joiningDate; // تاريخ الانضمام
  String attendanceStatus = 'Present'; // حالة الحضور الافتراضية
  File? _selectedImage; // الصورة المختارة

  @override
  void initState() {
    super.initState();
    // ملء الحقول بالقيم الحالية للموظف
    nameController.text = widget.oldEmployee.name;
    positionController.text = widget.oldEmployee.position;
    emailController.text = widget.oldEmployee.email;
    phoneController.text = widget.oldEmployee.phoneNumber ?? '';
    departmentController.text = widget.oldEmployee.department ?? '';
    addressController.text = widget.oldEmployee.address ?? '';
    joiningDate = widget.oldEmployee.joiningDate;
    attendanceStatus = widget.oldEmployee.attendanceStatus ?? 'Present';
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path); // تخزين الصورة
      });
    }
  }

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
    return AlertDialog(
      title: Text('Edit Employee'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    : widget.oldEmployee.imageUrl != null
                        ? Image.file(File(widget.oldEmployee.imageUrl!), fit: BoxFit.cover)
                        : Center(child: Text('Select Image')),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // إغلاق الحوار
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final updatedEmployee = Employee(
              name: nameController.text,
              position: positionController.text,
              email: emailController.text,
              phoneNumber: phoneController.text,
              department: departmentController.text,
              address: addressController.text,
              joiningDate: joiningDate,
              attendanceStatus: attendanceStatus,
              imageUrl: _selectedImage != null ? _selectedImage!.path : widget.oldEmployee.imageUrl,
            );
            Navigator.of(context).pop(updatedEmployee); // العودة بالقيم الجديدة
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
