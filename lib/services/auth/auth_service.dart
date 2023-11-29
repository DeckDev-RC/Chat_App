import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // Instancia da Autenticação
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Instancia do Firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Entrada do Usuário
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password, String username) async {
    try {
      // Entrada
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Adicionar um novo documento para o usuários em coleção usuários se ele ainda não existir
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));

      return userCredential;
    }
    // Pegando qualquer tipo de erros
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Criando um novo usuário
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password, username) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Depois de criar um novo Usuário, cria um documento para o usuário na coleção de usuários
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': username,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Saída do Usuário
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
