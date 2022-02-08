import 'package:awesome_chat/services/auth.dart';
import 'package:awesome_chat/services/database.dart';
import 'package:awesome_chat/widgets/check_password_validate.dart';
import 'package:awesome_chat/widgets/reusable_button.dart';
import 'package:awesome_chat/widgets/reusable_textfield.dart';
import 'package:awesome_chat/screens/signin_screen.dart';
import 'package:awesome_chat/utils/constants.dart';
import 'package:awesome_chat/utils/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

String password = "abcd@123";

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  bool obscureTextPassword = true;
  bool obscureTextRePassword = true;
  bool checkValidUsername = true;
  bool checkValidEmail = true;
  bool checkValidPassword = true;
  bool checkValidRePassword = true;
  bool inAsyncCall = false;

  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  bool hasMinLength = false;

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
          body: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  FlutterLogo(size: 100),
                  const SizedBox(height: 10.0),
                  Text("Sign Up An Account", style: kAppTitle),
                  const SizedBox(height: 10.0),
                  ReusableTextField(
                    textInputAction: TextInputAction.next,
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                    suffixIcon: null,
                    errorText:
                        checkValidUsername ? null : "Please fill in this field",
                    hintText: "Please enter your name",
                  ),
                  const SizedBox(height: 10.0),
                  ReusableTextField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    errorText: checkValidEmail ? null : "Your email is invalid",
                    prefixIcon: Icon(Icons.email, color: Colors.blue),
                    suffixIcon: null,
                    obscureText: false,
                    hintText: "Please enter your email",
                  ),
                  const SizedBox(height: 10.0),
                  ReusableTextField(
                    onChanged: (val) {
                      setState(() {
                        hasUppercase = val.contains(RegExp(r'[A-Z]'));
                        hasDigits = val.contains(RegExp(r'[0-9]'));
                        hasLowercase = val.contains(RegExp(r'[a-z]'));
                        hasSpecialCharacters =
                            val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                        hasMinLength = val.length >= 6;
                      });
                    },
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    errorText: checkValidPassword
                        ? null
                        : "password must be at least 6 characters including a number an uppercase letter and a lowercase letter",
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                    suffixIcon: GestureDetector(
                      child: obscureTextPassword
                          ? Icon(Icons.visibility, color: Colors.black)
                          : Icon(Icons.visibility_off, color: Colors.black),
                      onTap: () {
                        setState(() {
                          obscureTextPassword = !obscureTextPassword;
                        });
                      },
                    ),
                    obscureText: obscureTextPassword,
                    hintText: "Please enter your password",
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CheckPasswordRegExp(
                        checkPassSymbolizing: 'A',
                        checkPassDetail: "Uppercase",
                        condition: hasUppercase,
                      ),
                      CheckPasswordRegExp(
                        checkPassSymbolizing: 'a',
                        checkPassDetail: "Lowercase",
                        condition: hasLowercase,
                      ),
                      CheckPasswordRegExp(
                        checkPassSymbolizing: '1',
                        checkPassDetail: "Number",
                        condition: hasDigits,
                      ),
                      CheckPasswordRegExp(
                        checkPassSymbolizing: '6+',
                        checkPassDetail: "MinCount",
                        condition: hasMinLength,
                      ),
                      CheckPasswordRegExp(
                        checkPassSymbolizing: '#',
                        checkPassDetail: "Special",
                        condition: hasSpecialCharacters,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  ReusableTextField(
                    controller: _rePasswordController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    errorText:
                        checkValidRePassword ? null : "Password does not match",
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                    suffixIcon: GestureDetector(
                      child: obscureTextRePassword
                          ? Icon(Icons.visibility, color: Colors.black)
                          : Icon(Icons.visibility_off, color: Colors.black),
                      onTap: () {
                        setState(() {
                          obscureTextRePassword = !obscureTextRePassword;
                        });
                      },
                    ),
                    obscureText: obscureTextRePassword,
                    hintText: "Re-enter your password",
                  ),
                  const SizedBox(height: 10.0),
                  ReusableButton(
                    buttonTitle: 'Sign Up',
                    function: () => onSignUp(context),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "You already have an account?",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 16.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                SignInScreen.id, (route) => false);
                          },
                          child: Text("Login Now", style: kBlueNavTextButton),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onSignUp(BuildContext context) async {
    hideKeyboard(context);
    AuthMethods authMethods = AuthMethods();
    DatabaseMethods databaseMethods = DatabaseMethods();



    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String rePassword = _rePasswordController.text.trim();

    Validation validation = Validation();
    bool validEmail = validation.isValidEmail(email);
    bool validPass = validation.isValidPassword(password);

    setState(() {

      checkValidUsername = _usernameController.text.trim().isNotEmpty;
      checkValidEmail = validEmail;
      checkValidPassword = validPass;

      if (validPass == true) {
        checkValidRePassword = password == rePassword;
      }
    });

    if (validEmail &&
        checkValidRePassword &&
        _usernameController.text.trim().isNotEmpty) {
      setState(() {
        inAsyncCall = true;
      });

      await authMethods.createUserInWithEmailAndPassword(
          email, password, context);
      await databaseMethods.addUser(
          email: email, username: _usernameController.text);

      setState(() {
        inAsyncCall = false;
      });
    }
  }
}
