import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "/registration";
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Hero(
                tag: "logo",
                child: Icon(
                  Icons.bolt_rounded,
                  color: Colors.amberAccent,
                  size: 200.0,
                ),
              ),
            ),
            SizedBox(height: 48.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your Password',
              ),
            ),
            SizedBox(height: 24.0),
            ButtonWidget(
              color: Colors.blueAccent,
              buttonText: "Register",
              onPressed: () async {
                setState(() {
                  Center(
                    child: CircularProgressIndicator(),
                  );
                });
                try {
                  UserCredential userCredential =
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                  if (userCredential.user!.uid.isNotEmpty) {
                    Navigator.pushReplacementNamed(context, ChatScreen.id);
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
