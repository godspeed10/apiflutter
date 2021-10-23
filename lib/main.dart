import 'dart:convert';

import 'package:api/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: DataFromApi(),
    );
  }
}

class DataFromApi extends StatefulWidget {
  const DataFromApi({Key? key}) : super(key: key);

  @override
  _DataFromApiState createState() => _DataFromApiState();
}

class _DataFromApiState extends State<DataFromApi> {
  Future<List<User>> getUserData() async {
    final response =
        await http.get(Uri.http('api.sampleapis.com', 'futurama/characters'));
    final jsonData = jsonDecode(response.body);

    final users = (jsonData as List).map((e) => User.fromJson(e)).toList();

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('User'),
      ),
      body: Container(
        child: FutureBuilder<List<User>>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading"),
                ),
              );
            } else {
              final users = snapshot.data!;
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, i) {
                    return UserTile(user: users[i]);
                  });
            }
          },
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 11.0, spreadRadius: -2.0)
        ],
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const VerticalDivider(),
            CircleAvatar(
              child: Image.network(user.images.main),
              maxRadius: 48,
            ),
            const VerticalDivider(),
            Center(
              child: Text("${user.name.fullName} (${user.occupation})",
                  style: Theme.of(context).textTheme.subtitle2),
            ),
            const VerticalDivider(),
            Center(
              child: Text("${user.gender}, ${user.age} yo",
                  style: Theme.of(context).textTheme.caption),
            ),
            const VerticalDivider(),
            Center(child: Text("${user.species}, ${user.homePlanet}")),
            const VerticalDivider(),
            for (final saying in user.sayings) ...[
              Text(saying,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.black87)),
              const VerticalDivider(),
            ]
          ],
        ),
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 8);
  }
}


// [1,...[3,4,5], 2]  = [1,3,4,5,2]


/**
 * 
 * [name,divider,role,divider,...[saying1, divider],...[saying2, divider]]
 * 
 */