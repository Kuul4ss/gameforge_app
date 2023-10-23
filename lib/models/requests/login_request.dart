class LoginRequest{
  String pseudo;
  String password;

  LoginRequest({
    required this.pseudo,
    required this.password
});

  Map<String, dynamic> toJson() =>
      {
        "pseudo": pseudo,
        "password": password,
      };
}