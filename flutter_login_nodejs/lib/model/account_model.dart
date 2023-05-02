class AccountModel {
  final int id;
  final String nama;
  final String email;
  final String username;
  final String password;

  const AccountModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.username,
    required this.password,
  });

  static AccountModel fromJson(json) => AccountModel(
        id: json['id'],
        nama: json['nama'],
        email: json['email'],
        username: json['username'],
        password: json['password'],
      );
}
