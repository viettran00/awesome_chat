import 'package:awesome_chat/services/auth.dart';
import 'package:awesome_chat/services/database.dart';
import 'package:awesome_chat/utils/helper.dart';
import 'package:awesome_chat/widgets/reusable_button.dart';
import 'package:awesome_chat/widgets/reusable_textfield.dart';
import 'package:awesome_chat/screens/signup_screen.dart';
import 'package:awesome_chat/utils/constants.dart';
import 'package:awesome_chat/utils/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:awesome_chat/utils/globals.dart' as globals;
import 'forgot_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String id = "signin_screen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;
  bool emailValid = true;
  bool passwordValid = true;
  bool inAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: inAsyncCall,
      child: GestureDetector(
        onTap: () {
          // click outside to hide keyboard
          hideKeyboard(context);
        },
        child: Scaffold(
          body: WillPopScope(
            onWillPop: onWillPop,
            child: SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(size: 100.0),
                  SizedBox(height: 10),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText("Awesome Chat", textStyle: kAppTitle),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ReusableTextField(
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    prefixIcon: Icon(Icons.email, color: Colors.blue),
                    suffixIcon: null,
                    errorText: emailValid ? null : "Your email is invalid",
                    hintText: "Please enter your email",
                  ),
                  const SizedBox(height: 10.0),
                  ReusableTextField(
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: obscureText,
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                    suffixIcon: GestureDetector(
                        child: obscureText
                            ? Icon(Icons.visibility, color: Colors.black)
                            : Icon(Icons.visibility_off, color: Colors.black),
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        }),
                    errorText:
                        passwordValid ? null : "Incorrect password format",
                    hintText: "Please enter your password",
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context).pushNamed(ForgotPassword.id)
                        },
                        child:
                            Text("Forgot password?", style: kBlueNavTextButton),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  ReusableButton(
                    buttonTitle: "Login",
                    function: () => onLogin(context),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 16.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(SignUpScreen.id);
                          },
                          child: Text("Sign Up", style: kBlueNavTextButton),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onLogin(BuildContext context) async {

    AuthMethods authMethods = AuthMethods();

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    Validation validation = Validation();
    bool validEmail = validation.isValidEmail(email);
    bool validPass = validation.isValidPassword(password);
    setState(() {
      emailValid = validEmail;
      passwordValid = validPass;
    });
    // hide keyboard
    hideKeyboard(context);
    if (validEmail && validPass) {
      setState(() {
        inAsyncCall = true;
      });

      DatabaseMethods databaseMethods = DatabaseMethods();
      await authMethods.signInWithEmailAndPassword(email, password, context);
      await Helper.saveUserLoggedInSharedPreferences(true);
      databaseMethods.getUserByEmail(email).then((value) async{
        String username = (value.docs[0].data() as Map<String, dynamic>).values.elementAt(1);
        await Helper.saveUsernameSharedPreferences(username);
      });
      await Helper.saveUserEmailSharedPreferences(email);

      setState(() {
        globals.isLoggedIn = true;
        inAsyncCall = false;
      });
    }
  }
}
