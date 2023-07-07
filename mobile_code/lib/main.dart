import 'package:flutter/material.dart';

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
            const SizedBox(
              width: 20.0,
              height: 20.0,
            ),
            const Text(
              "Email                                                    ",
              textScaleFactor: 1.5,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 50.0,
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
              height: 50.0,
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
                            : Icons.visibility))),
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
              width: 250,
              height: 60,
              child: RawMaterialButton(
                fillColor: Colors.lightBlue,
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: const BorderSide(color: Colors.black),
                ),
                onPressed: () async {},
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
            const SizedBox(
              height: 22.0,
            ),
          ],
        )),
      ),
    );
  }
}
