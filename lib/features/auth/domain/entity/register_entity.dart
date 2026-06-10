class RegisterEntity {
  final String email;
  final String username;
  final String phone;
  final String password;
  final String passwordConfirmation;

  const RegisterEntity({
    required this.email,
    required this.username,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });
}