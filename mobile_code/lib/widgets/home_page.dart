import 'package:flutter/material.dart';
import 'package:mobile_code/widgets/sign_up.dart';
import 'package:mobile_code/widgets/login_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_code/widgets/welcome.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          child: const Text('Create User'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUp()));
          },
        ),
        const SizedBox(height: 20, width: 20),
        ElevatedButton(
          child: const Text('Login User'),
          onPressed: () async {
            String? value = await storage.read(key: "token_exist");
            if (value == "True") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Welcome()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginUser()));
            }
          },
        ),
      ],
    );
  }
}
