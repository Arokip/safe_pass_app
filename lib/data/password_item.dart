import 'package:uuid/uuid.dart';

class PasswordItem {
  String? id;
  final String serviceName;
  final String userName;
  final String password;

  PasswordItem({
    this.id,
    required this.serviceName,
    required this.userName,
    required this.password,
  }) {
    id ??= const Uuid().v4();
  }

  factory PasswordItem.fromMap(Map<String, dynamic> data) {
    return PasswordItem(
        id: data['id'],
        serviceName: data['serviceName'],
        userName: data['userName'],
        password: data['password']);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "serviceName": serviceName,
        "userName": userName,
        "password": password,
      };
}
