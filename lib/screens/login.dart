// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/user.dart';

class MyLogin extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginForm(
            nameController: nameController, pwController: pwController),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
    required this.nameController,
    required this.pwController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController pwController;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(80.0),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline1,
              ),
              UsernameTextField(nameController, ''),
              UsernameTextField(pwController, 'Password', obscureText: true),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                child: Text('ENTER'),
                onPressed: () {
                  //Navigator.pushReplacementNamed(context, '/catalog');
                  print(nameController.text);
                  print(pwController.text);
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                    Provider.of<UserModel>(context, listen: false)
                        .logon(nameController.text, pwController.text);
                    Navigator.pushNamed(context, '/catalog');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
              )
            ],
          )),
    );
  }
}

class UsernameTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hitText;
  final bool obscureText;
  UsernameTextField(this.controller, this.hitText, {this.obscureText = false});
  @override
  _UsernameTextFieldState createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Container(
            child: Text('852'),
          ),
          isDense: true,
          fillColor: Colors.blue,
          filled: false,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.green, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.red, width: 1)),
          hintText: widget.hitText,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'missing';
          }
          return null;
        },
      ),
    );
  }
}
