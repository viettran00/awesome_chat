import 'package:awesome_chat/services/database.dart';
import 'package:awesome_chat/utils/constants.dart';
import 'package:awesome_chat/utils/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();
  late Stream chatMessagesStream;

  Widget? messageList(String chatRoomID, String message) {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return ListView.builder(itemBuilder: (context, index) {
          return Text("${snapshot.data}");
        });
      },
    );
  }

  sendMessage(String chatRoomID, String message) async {
    if (_messageController.text.trim().isNotEmpty) {
      DateTime now = DateTime.now();
      Map<String, dynamic> messageMap = {
        "message": message,
        "sendBy": await Helper.getUsername() ?? "",
        "timeSend": now
      };
      databaseMethods.addConversationMessage(chatRoomID, messageMap);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    Stream<QuerySnapshot> data = FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc('${args['chatRoomID']}')
        .collection('chats')
        .snapshots();

    return GestureDetector(
      onTap: () {
        // hide keyboard
        hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xbfe2dfdc),
        appBar: AppBar(
          title: Text('${args['user']}'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Text("abc")
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _messageController,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        sendMessage(
                            '${args['chatRoomID']}', _messageController.text);
                        // DateTime now = DateTime.now();
                        // print('time: ${now.toString()}');
                      },
                      child: Icon(Icons.send, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
