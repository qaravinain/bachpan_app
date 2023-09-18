import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_code/models/update_model.dart';
import 'package:mobile_code/models/view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  UpdateUserState createState() => UpdateUserState();
}

class UpdateUserState extends State<UpdateUser> {
  late Future<UpdateUserModel> futureUpdateUser;
  final storage = const FlutterSecureStorage();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();

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
            child: const Text('update User'),
            onPressed: () {
              setState(() {
                futureUpdateUser = userUpdation(
                  _name.text,
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

  fetchUser() async {
    String? value = await storage.read(key: "secured_email");
    String urlViewUser = "http://192.168.1.104:7000/user/viewdetails/$value";
    print(urlViewUser);
    final response = await http.get(Uri.parse(urlViewUser));

    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return ViewUser.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<UpdateUserModel> userUpdation(String name, String dob, String country,
      String state, String city) async {
    String? value = await storage.read(key: "secured_email");
    String urlUpdateUser = "http://192.168.1.104:7000/user/update/$value";
    final http.Response response = await http.put(
      Uri.parse(urlUpdateUser),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'dob': dob,
        'country': country,
        'state': state,
        'city': city
      }),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return UpdateUserModel.fromJson(json.decode(response.body));
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
