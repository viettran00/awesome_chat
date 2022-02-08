import 'package:awesome_chat/screens/chat_screen.dart';
import 'package:awesome_chat/screens/forgot_password.dart';
import 'package:awesome_chat/screens/home_screen.dart';
import 'package:awesome_chat/screens/search_screen.dart';
import 'package:awesome_chat/screens/signin_screen.dart';
import 'package:awesome_chat/screens/signup_screen.dart';
import 'package:awesome_chat/utils/helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AweSomeChat extends StatefulWidget {
  const AweSomeChat({Key? key}) : super(key: key);

  @override
  _AweSomeChatState createState() => _AweSomeChatState();
}

class _AweSomeChatState extends State<AweSomeChat> {
  bool _initialized = false;
  bool _error = false;
  late bool isUserLoggedIn;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  getLoggedInState() async{
    await Helper.getUserLoggedInSharedPreferences().then((value){
      setState(() {
        isUserLoggedIn = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeFlutterFire();
    getLoggedInState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      return Text("Error");
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return CircularProgressIndicator();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isUserLoggedIn ? HomeScreen() :  SignInScreen(),
      routes: {
        SignInScreen.id: (context) => SignInScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ForgotPassword.id: (context) => ForgotPassword(),
        SearchScreen.id: (context) => SearchScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );

  }
}
