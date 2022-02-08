import 'package:awesome_chat/screens/chat_screen.dart';
import 'package:awesome_chat/services/database.dart';
import 'package:awesome_chat/utils/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const String id = 'search_screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isDeleteSearch = false;
  DatabaseMethods databaseMethods = DatabaseMethods();
  bool inAsyncCall = false;

  QuerySnapshot<Object?>? querySnapshot;

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b.replaceAll(' ', '')}_${a.replaceAll(' ', '')}";
    } else {
      return "${a.replaceAll(' ', '')}_${b.replaceAll(' ', '')}";
    }
  }

  Widget searchTile() {
    return (querySnapshot == null || querySnapshot!.size == 0)
        ? Container()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: querySnapshot!.size,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Stack(
                    children: [
                      ListTile(
                        title: Text((querySnapshot!.docs[index].data()
                                as Map<String, dynamic>)
                            .values
                            .elementAt(1)
                            .toString()),
                        subtitle: Text((querySnapshot!.docs[index].data()
                                as Map<String, dynamic>)
                            .values
                            .elementAt(0)
                            .toString()),
                      ),
                      Positioned(
                        right: 15.0,
                        top: 17.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: GestureDetector(
                            onTap: () async {
                              String myUsername =
                                  await Helper.getUsername() ?? "";
                              String user2 = (querySnapshot!.docs[index].data()
                                      as Map<String, dynamic>)
                                  .values
                                  .elementAt(1)
                                  .toString();
                              List<String> users = [myUsername, user2];

                              String chatRoomID =
                                  getChatRoomId(myUsername, user2);
                              Map<String, dynamic> chatRoomMap = {
                                'users': users,
                                'chatRoomID': chatRoomID
                              };

                              await databaseMethods.createChatRoom(
                                  chatRoomID, chatRoomMap);

                              // Navigator.of(context).pushNamed(ChatScreen.id,
                              //     arguments: {
                              //       'user': user2,
                              //       'chatRoomID': chatRoomID
                              //     });
                              Navigator.pushNamed(context, ChatScreen.id,
                                  arguments: {
                                    'user': user2,
                                    'chatRoomID': chatRoomID
                                  });

                              print("tap2");
                            },
                            child: Text("Message"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0)
                ],
              );
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  onSubmitted: (val) async {
                    setState(() {
                      inAsyncCall = true;
                    });
                    await databaseMethods.getUserByUsername(val).then((value) {
                      setState(() {
                        querySnapshot = value;
                        inAsyncCall = false;
                      });
                    });
                  },
                  autofocus: true,
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      isDeleteSearch = val.trim().isNotEmpty;
                    });
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Enter user name",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      suffixIcon: isDeleteSearch
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _searchController.clear();
                                  isDeleteSearch = false;
                                });
                              },
                              child: Icon(Icons.backspace_outlined,
                                  color: Colors.black))
                          : null,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                ),
              ),
              searchTile(),
            ],
          ),
        ),
      ),
    );
  }
}
