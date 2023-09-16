import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_code/models/authentication.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController(text: "Ravi Nain");
  final TextEditingController _email =
      TextEditingController(text: "ravinain100@gmail.com");
  final TextEditingController _password =
      TextEditingController(text: "password123");
  final TextEditingController _dob = TextEditingController(text: "01-01-2000");
  final TextEditingController _country = TextEditingController(text: "India");
  final TextEditingController _state = TextEditingController(text: "Haryana");
  final TextEditingController _city = TextEditingController(text: "Karnal");

  late Future<CreateUser> futureUser;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _name,
            decoration: const InputDecoration(hintText: 'Enter Name'),
          ),
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: 'Enter Email Address'),
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(hintText: 'Enter Password'),
          ),
          TextField(
            controller: _dob,
            decoration:
                const InputDecoration(hintText: 'Enter DOB (DD-MM-YYYY)'),
          ),
          TextField(
            controller: _country,
            decoration: const InputDecoration(hintText: 'Enter County'),
          ),
          TextField(
            controller: _state,
            decoration: const InputDecoration(hintText: 'Enter State'),
          ),
          TextField(
            controller: _city,
            decoration: const InputDecoration(hintText: 'Enter City'),
          ),
          ElevatedButton(
            child: const Text('Create User'),
            onPressed: () {
              setState(() {
                futureUser = userCreation(
                  _name.text,
                  _email.text,
                  _password.text,
                  _dob.text,
                  _country.text,
                  _state.text,
                  _city.text,
                );
              });
            },
          ),

          // RaisedButton is deprecated and shouldn't be used. Use ElevatedButton.

          // RaisedButton(
          //   child: Text('Create Data'),
          //   onPressed: () {
          //     setState(() {
          //       _futureAlbum = createAlbum(_controller.text);
          //     });
          //   },
          // ),
        ],
      ),
    );
  }

  Future<CreateUser> userCreation(String name, String email, String password,
      String dob, String country, String state, String city) async {
    final http.Response response = await http.post(
      Uri.parse('http://192.168.1.104:7000/user/createuser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'dob': dob,
        'country': country,
        'state': state,
        'city': city
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return CreateUser.fromJson(json.decode(response.body));
    } else {
      AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
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
