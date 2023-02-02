import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Registrarse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Image(
                    image: NetworkImage(
                        'https://images.vexels.com/media/users/3/129607/isolated/preview/f526eafda1a791f4a93b1ad7c62161e5-logotipo-de-hamburguesas-1.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                '¿Olvidastes la contraseña?',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 54, 153),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 54, 153),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Registrarse()));
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
