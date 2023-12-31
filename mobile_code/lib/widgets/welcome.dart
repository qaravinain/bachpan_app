import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_code/widgets/user/update.dart';
import 'package:mobile_code/widgets/user/view.dart';
import 'package:mobile_code/widgets/home_page.dart';
import 'package:mobile_code/widgets/user/update.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("welcome Page"),
          ElevatedButton(
            child: const Text('View Details'),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewUserData()));
            },
          ),
          ElevatedButton(
            child: const Text('Update information'),
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UpdateUser()));
            },
          ),
          ElevatedButton(
            child: const Text('Log Out'),
            onPressed: () async {
              await storage.deleteAll();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
        ],
      ),
    );
  }
}
