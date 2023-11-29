import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // Pegando a instancia de autenticação e Firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // ENVIAR MENSAGEM
  Future<void> sendMessage(String receiverId, String message) async {
    // Obter informações do usuário atual
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // Obter o campo 'username' do documento do usuário no Firestore
    DocumentSnapshot userSnapshot =
        await _fireStore.collection('users').doc(currentUserId).get();
    final String currentUserUsername = userSnapshot['username'].toString();

    // Criar uma nova mensagem
    Message newMessage = Message(
      senderId: currentUserId,
      senderUsername: currentUserUsername,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // Construir o ID da sala de bate-papo a partir do ID do usuário atual e do ID do destinatário (ordenado para garantir a singularidade)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // Ordene os IDs (isso garante que o ID da sala de bate-papo seja sempre o mesmo para qualquer par de pessoas)
    String chatRoomId = ids.join(
        '_'); // Combine os IDs em uma única string para usar como chatroomId

    // Adicionar nova mensagem ao banco de dados
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // RECEBER MENSAGEM
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // Construa o ID da sala de bate-papo a partir dos IDs de usuário (ordenados para garantir que corresponda ao ID usado ao enviar mensagem)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
