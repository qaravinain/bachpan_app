import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_code/models/login.dart';
import 'package:mobile_code/widgets/welcome.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State<LoginUser> {
  final storage = const FlutterSecureStorage();
  final TextEditingController _email =
      TextEditingController(text: "ravinain100@gmail.com");
  final TextEditingController _password =
      TextEditingController(text: "password123");

  late Future<LoginUserModel> futureUser;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: 'Enter Email Address'),
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(hintText: 'Enter Password'),
          ),
          ElevatedButton(
              child: const Text('Login In'),
              onPressed: () {
                setState(() {
                  futureUser = userLogin(
                    _email.text,
                    _password.text,
                  );
                });
              }),
        ],
      ),
    );
  }

  Future<LoginUserModel> userLogin(String email, String password) async {
    final http.Response response = await http.post(
      Uri.parse('http://192.168.1.104:7000/get_token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final token = json.decode(response.body);
      print(token["token"]);
      await storage.write(key: "secured_token", value: token["token"]);
      await storage.write(key: "token_exist", value: "True");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Welcome()));

      return LoginUserModel.fromJson(json.decode(response.body));
    } else {
      AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      );
      throw Exception('Album loading failed!');
    }
  }
}
