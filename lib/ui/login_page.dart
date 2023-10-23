import 'package:flutter/material.dart';
import 'package:gameforge_app/models/either/either.dart';
import 'package:gameforge_app/models/entities/user.dart';

import '../models/entities/user_manager.dart';
import '../services/service_api.dart';
import '../models/requests/login_request.dart';
import 'connected_menu_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signUserIn() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      final result = await ServiceAPI().connection(
        LoginRequest(pseudo: pseudoController.text, password: passwordController.text)
      );
      Navigator.of(context).pop();
        if (result is Success<User,String>) {
          UserManager.currentUser = result.value;
          Navigator.of(context).pushNamed(ConnectedMenuPage.routeName);
        } else if(result is Failure<User,String>) {
          _showWrongCredentialsDialog(result.error);
        }

    }
  }

  void _showWrongCredentialsDialog(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 200,
                  ),
                  const SizedBox(height: 75),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: _textFieldValidator,
                      controller: pseudoController,
                      decoration: const InputDecoration(labelText: "Identifiant"),
                      obscureText: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: _textFieldValidator,
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: "Mot de passe"),
                      obscureText: true,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _signUserIn,
                    child: const Text("Connexion"),
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _textFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Saisissez un texte';
    }
    return null;
  }
}