import 'package:flutter/material.dart';
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
class EditEmployeeDialog extends StatelessWidget {
  final Employee oldEmployee;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  EditEmployeeDialog({Key? key, required this.oldEmployee}) : super(key: key) {
    nameController.text = oldEmployee.name;
    positionController.text = oldEmployee.position;
    emailController.text = oldEmployee.email;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Employee'),
      content: Column(
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
        ],
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
            // إنشاء موظف جديد مع القيم المعدلة
            final updatedEmployee = Employee(
              name: nameController.text,
              position: positionController.text,
              email: emailController.text,
            );
            Navigator.of(context).pop(updatedEmployee); // العودة بالقيم الجديدة
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
