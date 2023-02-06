import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _isLogin = true;

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FormBuilder(
          key: _fbKey,
          child: Column(
            children: <Widget>[
              if (_isLogin)
                FormBuilderTextField(
                  attribute: "email",
                  decoration: InputDecoration(labelText: "Email"),
                  validators: [
                    FormBuilderValidators.email(),
                    FormBuilderValidators.required(),
                  ],
                ),
              if (_isLogin)
                FormBuilderTextField(
                  attribute: "password",
                  decoration: InputDecoration(labelText: "Password"),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(8),
                  ],
                  obscureText: true,
                ),
              if (!_isLogin)
                FormBuilderTextField(
                  attribute: "name",
                  decoration: InputDecoration(labelText: "Name"),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                ),
              if (!_isLogin)
                FormBuilderTextField(
                  attribute: "email",
                  decoration: InputDecoration(labelText: "Email"),
                  validators: [
                    FormBuilderValidators.email(),
                    FormBuilderValidators.required(),
                  ],
                ),
              if (!_isLogin)
                FormBuilderTextField(
                  attribute: "password",
                  decoration: InputDecoration(labelText: "Password"),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(8),
                  ],
                  obscureText: true,
                ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(_isLogin ? "Login" : "Register"),
                onPressed: () {
                  if (_fbKey.currentState.saveAndValidate()) {
                    print(_fbKey.currentState.value);
                    // Aquí puedes enviar los datos del formulario a una API o base de datos para procesarlos.
                  }
                },
              ),
              FlatButton(
                child: Text(_isLogin ? "Register" : "Login"),
                onPressed: _toggleForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

