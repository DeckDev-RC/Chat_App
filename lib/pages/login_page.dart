import 'package:chat_app/components/button_lr.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controladores de texto
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  // Login do usuário
  Future<void> signIn() async {
    // Pegando serviço de autenticação
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
        emailController.text,
        passwordController.text,
        usernameController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),

                  // Logo
                  Icon(
                    Icons.message,
                    size: 100,
                    color: Colors.blue[800],
                  ),

                  const SizedBox(height: 50),

                  // Bem-vindo (nome do app)
                  const Text(
                    'Bem-vindo de volta, você fez falta!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Caixa de email
                  MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false),

                  const SizedBox(height: 10),

                  // Caixa de senha
                  MyTextField(
                      controller: passwordController,
                      hintText: 'Senha',
                      obscureText: true),

                  const SizedBox(height: 25),

                  // Botão de entrar
                  ButtonLR(
                    onTap: signIn,
                    text: 'Entrar',
                  ),

                  const SizedBox(height: 50),

                  // Não é um membro? registre-se agora
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Não é um membro?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Registre-se agora',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
