import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_nodejs/fetch/account_fetch.dart';
import 'package:flutter_login_nodejs/view/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 2,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Username',
                  // The MaterialStateProperty's value is a text style that is orange
                  // by default, but the theme's error color if the input decorator
                  // is in its error state.
                  floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                      (Set<MaterialState> states) {
                    final Color color = states.contains(MaterialState.error)
                        ? Theme.of(context).colorScheme.error
                        : Colors.orange;
                    return TextStyle(color: color, letterSpacing: 1.3);
                  }),
                ),
                validator: (String? value) {
                  if (value == null || value == '') {
                    return 'Enter username';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  // The MaterialStateProperty's value is a text style that is orange
                  // by default, but the theme's error color if the input decorator
                  // is in its error state.
                  floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                      (Set<MaterialState> states) {
                    final Color color = states.contains(MaterialState.error)
                        ? Theme.of(context).colorScheme.error
                        : Colors.orange;
                    return TextStyle(color: color, letterSpacing: 1.3);
                  }),
                ),
                validator: (String? value) {
                  if (value == null || value == '') {
                    return 'Enter Password';
                  }
                  return null;
                },
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 35),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: MaterialButton(
                  onPressed: () async {
                    final result = await AccountApi.userLogin(
                        _usernameController.text, _passwordController.text);

                    if (result is String) {
                      print(result);
                    } else {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setString('token', jsonEncode(result));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MainPage()));
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueAccent,
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
