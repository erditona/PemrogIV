import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      id: user['id'],
      email: user['email'],
      firstName: user['first_name'],
      lastName: user['last_name'],
      avatar: user['avatar'],
    );
  }
}

class UserCreate {
  final String? id;
  final String name;
  final String job;
  final String? createdAt;

  UserCreate({
    this.id,
    required this.name,
    required this.job,
    this.createdAt,
  });

  factory UserCreate.fromJson(Map<String, dynamic> user) {
    tz.initializeTimeZones();
    final jakartaTimeZone = tz.getLocation('Asia/Jakarta');
    final jakartaCurrentTime = tz.TZDateTime.now(jakartaTimeZone);
    final createdAt = DateFormat.yMd().add_jm().format(jakartaCurrentTime);
    return UserCreate(
      id: user['id'],
      name: user['name'],
      job: user['job'],
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'job': job,
    };
  }

  @override
  String toString() {
    return 'UserCreate{id: $id, name: $name, job: $job, createdAt: $createdAt}';
  }
}

class UserPut {
  final String id; // Add the id field
  final String name;
  final String job;
  final String? updatedAt;

  UserPut({
    required this.id,
    required this.name,
    required this.job,
    this.updatedAt,
  });

  // Named constructor for creating a copy
  UserPut.copy(UserPut userPut)
      : id = userPut.id, // Copy the id field
        name = userPut.name,
        job = userPut.job,
        updatedAt = userPut.updatedAt;

  factory UserPut.fromJson(Map<String, dynamic> user) {
    tz.initializeTimeZones();
    final jakartaTimeZone = tz.getLocation('Asia/Jakarta');
    final jakartaCurrentTime = tz.TZDateTime.now(jakartaTimeZone);
    final updatedAt = DateFormat.yMd().add_jm().format(jakartaCurrentTime);
    return UserPut(
      id: user['id'], // Retrieve the id from the JSON
      name: user['name'],
      job: user['job'],
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include the id in the JSON
      'name': name,
      'job': job,
    };
  }

  @override
  String toString() {
    return 'UserPut{id: $id, name: $name, job: $job, updatedAt: $updatedAt}';
  }
}
