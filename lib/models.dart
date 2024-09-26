class Employee {
  final String name;
  final String position;
  final String email;
  final String? imageUrl; // رابط الصورة للموظف (يمكن أن يكون null)

  Employee({
    required this.name,
    required this.position,
    required this.email,
    this.imageUrl, required String phoneNumber, required String department, required String address, DateTime? joiningDate, required String attendanceStatus,
  });

  get phoneNumber => null;

  get department => null;

  get address => null;

  DateTime? get joiningDate => null;

  get attendanceStatus => null;
}
