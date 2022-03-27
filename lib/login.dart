import 'dart:convert';
import 'dart:ui';
import 'package:aplikasi_buku_tamu/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = false;
  bool _isHidePassword = true;

  Future userLogin() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String username = usernameController.text;
    String password = passwordController.text;

    // SERVER LOGIN API URL
    var url = 'http://114.4.37.148/bukutamu/index.php/auth/login';

    // Store all data with Param Name.
    var data = {'username': username, 'password': password};

    // Starting Web API Call.
    var response = await  http.post(url, body: json.encode(data));
    print(response.body);
    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if (message['success'] == 1) {
      // Hiding the CircularProgressIndicator.
      setState(
        () {
          visible = false;
        },
      );

      // Navigate to Profile Screen & Sending username to Next Screen.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    } else {
      // If username or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Username/Password Salah"),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue[50],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[50], Colors.blue[300]],
          ),
        ),
        child: ListView(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 50,
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo-home.png'),
                  // scale: 100.0,
                  //fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
              child: TextField(
                controller: usernameController,
                keyboardType: TextInputType.text,
                selectionWidthStyle: BoxWidthStyle.max,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle:
                      new TextStyle(color: Colors.black54, fontSize: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),
            SizedBox(
              width: 50,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _isHidePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    labelText: 'Password',
                    labelStyle:
                        new TextStyle(color: Colors.black54, fontSize: 16.0),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _togglePasswordVisibility();
                      },
                      child: Icon(
                        _isHidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color:
                            _isHidePassword ? Colors.black54 : Colors.black54,
                      ),
                    ),
                    //filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters!';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 60),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: SizedBox(
                    width: 50,
                  )),
                  Expanded(
                      child: SizedBox(
                    width: 50,
                  )),
                  Expanded(
                      child: SizedBox(
                    width: 30,
                  )),
                  // tombol kembali
                  Expanded(
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text('Login', style: TextStyle(fontSize: 22.0)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: (userLogin),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
