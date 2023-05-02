import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_nodejs/fetch/account_fetch.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var username = '';
  var name = '';
  var email = '';

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then(
      (pref) {
        setToken(json.decode(pref.getString("token")!));
      },
    );
    super.initState();
  }

  void setToken(Map token) async {
    var accountData = await AccountApi.getuser(token['userId']);
    setState(() {
      username = accountData['username'];
      name = accountData['name'];
      email = accountData['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildBody(context),
        floatingActionButton: _getFAB(),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Name: $name",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Username: $username",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Email: $email",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _getFAB() {
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: const IconThemeData(size: 22),
    backgroundColor: Colors.blue,
    visible: true,
    curve: Curves.bounceIn,
    children: [
      // FAB 1
      SpeedDialChild(
          child: const Icon(Icons.logout),
          backgroundColor: Colors.blue,
          onTap: () {/* do anything */},
          label: 'Log Out',
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16.0),
          labelBackgroundColor: Colors.white),
      // FAB 2
      SpeedDialChild(
          child: const Icon(Icons.edit),
          backgroundColor: Colors.blue,
          onTap: () {/* do anything */},
          label: 'Edit',
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16.0),
          labelBackgroundColor: Colors.white),
      SpeedDialChild(
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
          onTap: () {/* do anything */},
          label: 'Add',
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16.0),
          labelBackgroundColor: Colors.white),
    ],
  );
}
