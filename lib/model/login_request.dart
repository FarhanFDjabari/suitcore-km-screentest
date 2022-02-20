class LoginRequest {
  String email;
  String password;
  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': this.email,
        'password': this.password,
      };
}
