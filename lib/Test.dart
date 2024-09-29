import 'package:flutter/material.dart';


class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AttendancePage(),
    );
  }
}

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<AttendanceRecord> records = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController checkInController = TextEditingController();
  final TextEditingController checkOutController = TextEditingController();
  String status = 'حاضر';

  void _addRecord() {
    setState(() {
      records.add(AttendanceRecord(
        nameController.text,
        dateController.text,
        checkInController.text,
        checkOutController.text,
        status,
      ));
      nameController.clear();
      dateController.clear();
      checkInController.clear();
      checkOutController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تتبع الحضور'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إضافة سجل حضور',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'اسم الموظف'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'تاريخ الحضور (YYYY-MM-DD)'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: checkInController,
                decoration: InputDecoration(labelText: 'وقت الدخول'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: checkOutController,
                decoration: InputDecoration(labelText: 'وقت الخروج'),
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: status,
                onChanged: (String? newValue) {
                  setState(() {
                    status = newValue!;
                  });
                },
                items: <String>['حاضر', 'غائب', 'إجازة']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addRecord,
                child: Text('إضافة سجل'),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Prevent scrolling
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(record.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('تاريخ: ${record.date}'),
                          Text('وقت الدخول: ${record.checkIn}'),
                          Text('وقت الخروج: ${record.checkOut}'),
                          Text('حالة الحضور: ${record.status}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttendanceRecord {
  final String name;
  final String date;
  final String checkIn;
  final String checkOut;
  final String status;

  AttendanceRecord(this.name, this.date, this.checkIn, this.checkOut, this.status);
}
