import 'package:flutter/material.dart';
import 'package:system/Employeedetails.dart';
import 'package:system/models.dart';

class EmployeeList extends StatelessWidget {
  final List<Employee> employees;
  final Function onDelete; // تأكد من أن هذه الدالة تمرر بشكل صحيح
  final Function onEdit;

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
        title: Text('قائمة الموظفين'),
      ),
      body: employees.isEmpty
          ? Center(child: Text('لا يوجد موظفين مضافين بعد.'))
          : ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.blueAccent, width: 1.5),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: employee.imageUrl != null
                          ? NetworkImage(employee.imageUrl!)
                          : null,
                      child: employee.imageUrl == null
                          ? Icon(Icons.person, size: 40)
                          : null,
                    ),
                    title: Text(
                      employee.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text('المسمى الوظيفي: ${employee.position}'),
                        SizedBox(height: 5),
                        Text('البريد الإلكتروني: ${employee.email}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            onEdit(employee);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            onDelete(employee); // استدعاء دالة الحذف
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeDetails(
                            employee: employee,
                            onDelete: onDelete,
                            onEdit: onEdit,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
