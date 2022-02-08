import 'package:awesome_chat/screens/search_screen.dart';
import 'package:awesome_chat/screens/signin_screen.dart';
import 'package:awesome_chat/utils/constants.dart';
import 'package:awesome_chat/utils/helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: Text("Notification"),
      content: Text("Do you want to sign out?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("No"),
        ),
        TextButton(
          // sign out -  log out
          onPressed: () async {
            await Helper.saveUserLoggedInSharedPreferences(false);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(SignInScreen.id, (route) => false);
          },
          child: Text("Yes"),
        ),
      ],
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Awesome Chat"),
        actions: [
          GestureDetector(
            onTap: () { // go to search screen
              Navigator.of(context).pushNamed(SearchScreen.id);
            },
            child: Icon(Icons.search, color: Colors.white, size: 30.0),
          ),
          const SizedBox(width: 10.0),
          GestureDetector(
              onTap: () {
                showDialog(context: context, builder: (context) => dialog);
              },
              child: Icon(Icons.logout, color: Colors.white, size: 30.0)),
          const SizedBox(width: 10.0),
        ],
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Center(
          child: Container(
              color: Colors.green,
              child: TextButton(
                onPressed: () {

                  // String? _username = await Helper.getUsersname();
                  // String? _email = await Helper.getUserEmail();
                  //
                  // print('username:$_username\nemail:$_email');
                  //
                  // String chatRoomId = getChatRoomId('akali',"Nguyen Zan Thuan");
                  // print('chat room id: $chatRoomId');

                  // FirebaseFirestore.instance
                  //     .collection('users').where('email', isEqualTo: 'thuan@gmail.com')
                  //     .get()
                  //     .then((value) => {
                  //   print(value.docs[0].data().values.elementAt(1))
                  // });
                },
                child: Text(
                  'OPEN LOG',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ),
      ),
    );
  }
}
