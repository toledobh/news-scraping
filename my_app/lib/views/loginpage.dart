//settings page PAGE#2 
import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // ignore: avoid_unnecessary_containers
            Container(
              height: 400,
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {},
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
