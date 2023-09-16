import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/authentication.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isHidePassword = true;

  String status = "";
  String token = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage("https://i.imgur.com/a2AVdN1.png"),
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
              height: 20.0,
            ),
            const Text("Log In", textScaleFactor: 1.5),
            // const SizedBox(
            //   width: 20.0,
            //   height: 20.0,
            // ),
            const Text(
              "Email                                                    ",
              textScaleFactor: 1.5,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 40.0,
              width: 330.0,
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    filled: true,
                    // rgba(15,153,254,255)
                    fillColor: Colors.lightBlue,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    hintText: "example@gmail.com",
                    prefixIcon: Icon(
                      Icons.mark_email_read_sharp,
                      color: Colors.white,
                    )),
              ),
            ),
            const SizedBox(
              width: 10.0,
              height: 10.0,
            ),
            const Text(
              "Password                                            ",
              textScaleFactor: 1.5,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 40.0,
              width: 330.0,
              child: TextField(
                controller: passwordController,
                obscureText: isHidePassword,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.lightBlue,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    hintText: "********",
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.white,
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          //   setState(() {
                          //     if (isHidePassword == true) {
                          //       isHidePassword = false;
                          //     } else {
                          //       isHidePassword = true;
                          //     }
                          //   });
                        },
                        child: Icon(isHidePassword
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    iconColor: Colors.white),
              ),
            ),
            const SizedBox(
              width: 10.0,
              height: 10.0,
            ),
            const Text(
              "                                                              Forgot password?",
              style: TextStyle(color: Colors.lightBlue),
            ),
            const SizedBox(
              width: 20.0,
              height: 20.0,
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: RawMaterialButton(
                fillColor: Colors.lightBlue,
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: const BorderSide(color: Colors.black),
                ),
                onPressed: () async {
                  signIn(emailController.text, passwordController.text);
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 22.0,
              child: Text(
                  "-------------------------- OR --------------------------"),
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: RawMaterialButton(
                fillColor: Colors.lightBlue,
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: const BorderSide(color: Colors.black),
                ),
                onPressed: () async {},
                child: const Text(
                  "Create Account",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  // void signIn() async {
  //   const url = "http://192.168.1.9:7000/get_token";
  //   final uri = Uri.parse(url);
  //   final response = await http.post(uri);
  //   final body = response.body;
  //   final data = jsonDecode(body);
  //   status = data["Bachpan"];

  //   print(status);
  // }

  Future<Authentication> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.9:7000/get_token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(Authentication.fromJson(jsonDecode(response.body)));
      return Authentication.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
