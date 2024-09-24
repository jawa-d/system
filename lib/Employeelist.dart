import 'package:flutter/material.dart';
import 'package:system/Employeedetails.dart';
import 'package:system/models.dart';

class EmployeeList extends StatelessWidget {
  final List<Employee> employees;
  final Function onDelete; // دالة الحذف
  final Function onEdit; // دالة التعديل

  EmployeeList({
    Key? key,
    required this.employees,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: employees.isEmpty
          ? Center(child: Text('No employees added yet.'))
          : ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text('${employee.position} - ${employee.email}'),
                  onTap: () {
                    // الانتقال إلى صفحة تفاصيل الموظف عند النقر
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeDetails(
                          employee: employee,
                          onDelete: onDelete, // تمرير دالة الحذف
                          onEdit: onEdit, // تمرير دالة التعديل
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
