import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // usuário

  // todos usuários

  //campo edição

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),

          //foto de perfil
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(25),
                child: const Icon(
                  Icons.person,
                  size: 72,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          //email do usuário
          Text(
            'Meu nome',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green[500],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 50),

          //detalhes do usuário
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Meus Detalhes',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          //nome do usuário
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Meu Nome'),
            ],
          ),

          //bio
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Meu Nome'),
            ],
          ),

          const SizedBox(height: 50),

          //posts do usuário
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Meus Posts',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Barra de navegação inferior
    );
  }
}
