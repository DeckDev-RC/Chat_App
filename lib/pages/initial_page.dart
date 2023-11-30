import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
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
      backgroundColor: const Color(0xFF626868),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(60),
          ),
        ),
        backgroundColor: const Color(0xFF273C2C),
        centerTitle: true,
        title: const Text(
          'Página Incial',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          // Botão de sair
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: signOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: _buildUserList(),

      // Barra de navegação inferior
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
            ),
          ),
        ),
        title: Text(
          data['username'],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
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
