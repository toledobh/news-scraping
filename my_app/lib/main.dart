import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Scraper',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.red.shade300],
          ),
        ),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text ("Fakey Wakey",
                style: TextStyle(
                fontFamily:'Roboto',
                fontSize: 40.8,
                color: Colors.white
                ),
                ),
                Image.asset(
                  'assets/newspaper.png',
                  height: 240,
                  width: 240,
                  fit: BoxFit.fitHeight,
                ),
                buildElevatedButton(),
              ]),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 64.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                ),
                child: const Text('Menu'),
              ),
            ),
            ListTile(
              title: const Text('Instructions'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SecondPage(title: 'Settings');
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
// Widget buildElevatedButton() => ElevatedButton.icon(
//         style: ElevatedButton.styleFrom(
//           foregroundColor: Colors.white,
//           backgroundColor: Colors.blue,
//           minimumSize: const Size(280, 80), // foreground text color
//           textStyle: const TextStyle(fontSize: 36),
//         )
Widget buildElevatedButton() => ElevatedButton.icon(onPressed: onPressed, icon: const Icon(Icons.favorite, size: 0,color: Colors.blueAccent,),  label: const Text('PLAY'));

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}

void onPressed() {
}
