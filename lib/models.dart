class Employee {
  final String name;
  final String position;
  final String email;
  final String? imageUrl; // رابط الصورة للموظف (يمكن أن يكون null)

  Employee({
    required this.name,
    required this.position,
    required this.email,
    this.imageUrl,
  });
}
