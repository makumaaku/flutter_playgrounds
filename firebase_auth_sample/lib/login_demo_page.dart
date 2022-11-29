import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginDemoPage extends StatelessWidget {
  const LoginDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Emulator Sample'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final credential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: 'dash@email.com', password: 'password');
              print(credential.user);
            } catch (e, st) {
              print('$e\n$st');
            }
          },
          child: const Text('ログイン'),
        ),
      ),
    );
  }
}
