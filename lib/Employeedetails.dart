import 'package:flutter/material.dart';
import 'package:system/models.dart';

class EmployeeDetails extends StatelessWidget {
  
  final Employee employee;
  final Function onDelete; // دالة الحذف
  final Function onEdit; // دالة التعديل

  EmployeeDetails({
    Key? key,
    required this.employee,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(
        
        title: Text('Employee Details'),
        actions: [
          
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // استدعاء دالة التعديل
              onEdit(employee);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // تأكيد الحذف
              _showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.blueAccent, width: 2.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.person, size: 40),
                  title: Text(
                    'Name: ${employee.name}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.work, size: 40),
                  title: Text(
                    'Position: ${employee.position}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.email, size: 40),
                  title: Text(
                    'Email: ${employee.email}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Employee'),
          content: Text('Are you sure you want to delete this employee?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الحوار
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(employee); // استدعاء دالة الحذف
                Navigator.of(context).pop(); // إغلاق الحوار
                Navigator.of(context).pop(); // العودة إلى قائمة الموظفين
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
