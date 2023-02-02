import 'package:flutter/material.dart';

class Registrarse extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Registrarse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
      ),
      body: Center(
        child: Container(
          height: 80,
          width: 150,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(10)),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Registrarse',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
