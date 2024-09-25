import 'package:flutter/material.dart';
import 'package:system/Employeedetails.dart';
import 'package:system/models.dart';

class EmployeeList extends StatelessWidget {
  final List<Employee> employees;
  final Function onDelete;
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
        title: Text('Employee List'),
      ),
      body: employees.isEmpty
          ? Center(child: Text('No employees added yet.'))
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
                        Text('Position: ${employee.position}'),
                        SizedBox(height: 5),
                        Text('Email: ${employee.email}'),
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
                            onDelete(employee);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EmployeeDetails(employee: employee, onDelete: onDelete, onEdit: onEdit),
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
