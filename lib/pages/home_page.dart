import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instancia de autenticação
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Saída do usuário
  void signOut() {
    //Pegando o serviço de autenticação
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Página Incial',
        ),
        actions: [
          // Botão de sair
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: _buildUserList(),
    );
  }

  // Criar uma lista de usuários, exceto o usuário atualmente conectado
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('erro');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Carregando...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  // Construir itens de lista individuais de usuários
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Exibir todos os usuários, exceto o usuário atual
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['username']),
        onTap: () {
          // Enviar o UID do usuário clicado para a página de bate-papo
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: data['username'],
                receiverUserID: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      // Retornar um contêiner vazio
      return Container();
    }
  }
}
