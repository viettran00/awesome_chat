import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  Future<void> addUser({required String email, required String username}) {
    return users
        .add({'email': email, 'username': username})
        .then((value) => print("user added"))
        .catchError((err) => print("error ${err.toString()}"));
  }

  Future<QuerySnapshot<Object?>> getUserByUsername(String keySearch) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where('username', isEqualTo: keySearch)
        .get();
  }

  Future<QuerySnapshot<Object?>> getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
  }

  createChatRoom(String chatRoomID, chatRoomMap) async {
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((err) {
      print('error: $err');
    });
  }

  addConversationMessage(String chatRoomID, messageMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomID)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print('err: ${e.toString()}');
    });
  }
  getConversationMessage(String chatRoomID){
    return FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomID)
        .collection('chats')
        .snapshots();
  }
}
