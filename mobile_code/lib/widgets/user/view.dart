import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_code/models/view_model.dart';

class ViewUserData extends StatefulWidget {
  const ViewUserData({super.key});

  @override
  State<ViewUserData> createState() => _ViewUserDataState();
}

class _ViewUserDataState extends State<ViewUserData> {
  late Future<ViewUser> futureAlbum;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<ViewUser>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return Text((snapshot.data!.name).toString());
                return Column(
                  children: [
                    Text((snapshot.data!.name).toString()),
                    Text((snapshot.data!.email).toString()),
                    Text((snapshot.data!.dob).toString()),
                    Text((snapshot.data!.country).toString()),
                    Text((snapshot.data!.state).toString()),
                    Text((snapshot.data!.city).toString()),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future<ViewUser> fetchUser() async {
    String? value = await storage.read(key: "secured_email");
    String urlViewUser = "http://192.168.1.104:7000/user/viewdetails/$value";
    print(urlViewUser);
    final response = await http.get(Uri.parse(urlViewUser));

    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ViewUser.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
