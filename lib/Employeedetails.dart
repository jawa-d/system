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
        title: Text('تفاصيل الموظف'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => onEdit(employee), // استدعاء دالة التعديل
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmationDialog(context),
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
                _buildEmployeeDetailRow(Icons.person, 'الاسم: ${employee.name}', 24, FontWeight.bold),
                Divider(),
                _buildEmployeeDetailRow(Icons.work, 'المسمى الوظيفي: ${employee.position}', 20, FontWeight.normal),
                Divider(),
                _buildEmployeeDetailRow(Icons.email, 'البريد الإلكتروني: ${employee.email}', 20, FontWeight.normal),
                Divider(),
                _buildEmployeeDetailRow(Icons.phone, 'رقم الهاتف: ${employee.phoneNumber}', 20, FontWeight.normal),
                Divider(),
                _buildEmployeeDetailRow(Icons.business, 'القسم: ${employee.department}', 20, FontWeight.normal),
                Divider(),
                _buildEmployeeDetailRow(Icons.location_on, 'العنوان: ${employee.address}', 20, FontWeight.normal),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeDetailRow(IconData icon, String title, double fontSize, FontWeight fontWeight) {
    return ListTile(
      leading: Icon(icon, size: 40, color: Colors.blueAccent),
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حذف الموظف'),
          content: Text('هل أنت متأكد أنك تريد حذف هذا الموظف؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // إغلاق الحوار
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                onDelete(employee); // استدعاء دالة الحذف
                Navigator.of(context).pop(); // إغلاق الحوار
                Navigator.of(context).pop(); // العودة إلى قائمة الموظفين
              },
              child: Text('حذف'),
            ),
          ],
        );
      },
    );
  }
}
