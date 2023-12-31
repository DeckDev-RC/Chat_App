import 'package:chat_app/routes/home_page_routes.dart';
import 'package:chat_app/services/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Se o usuário está logado
          if (snapshot.hasData) {
            return const HomePageRoutes();
          }

          // Se o usuário não está logado
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
