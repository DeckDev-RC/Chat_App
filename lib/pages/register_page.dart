import 'package:chat_app/components/button_lr.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controladores de texto
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Cadastro do usuário
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Senhas não coincidem!'),
        ),
      );
      return;
    }

    // Pegando Autenticação do serviço
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
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
                  const SizedBox(height: 50),

                  // Logo
                  Icon(
                    Icons.message,
                    size: 100,
                    color: Colors.grey[800],
                  ),

                  const SizedBox(height: 50),

                  // Vamos criar uma conta
                  const Text(
                    'Vamos criar uma conta para você!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Caixa de nome de usuário
                  MyTextField(
                      controller: usernameController,
                      hintText: 'Nome de usuário',
                      obscureText: false),

                  const SizedBox(height: 10),

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

                  const SizedBox(height: 10),

                  // Caixa de confirmar senha
                  MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirmar senha',
                      obscureText: true),

                  const SizedBox(height: 25),

                  // Botão de registrar
                  ButtonLR(
                    onTap: signUp,
                    text: 'Cadastrar',
                  ),

                  const SizedBox(height: 50),

                  // Já é um membro? Entre agora
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Já é um membro?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Entre agora',
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
