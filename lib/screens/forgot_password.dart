import 'package:awesome_chat/screens/signin_screen.dart';
import 'package:awesome_chat/services/auth.dart';
import 'package:awesome_chat/utils/constants.dart';
import 'package:awesome_chat/utils/validation.dart';
import 'package:awesome_chat/widgets/reusable_button.dart';
import 'package:awesome_chat/widgets/reusable_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);
  static const String id = 'forgot_password';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool emailValid = true;
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
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: FlutterLogo(size: 150)),
                const SizedBox(height: 10.0),
                Text("Enter your email to reset password",
                    style: kResetPassTitle),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  textInputAction: TextInputAction.done,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: null,
                  errorText: emailValid ? null : "Your email is invalid",
                  hintText: "Please enter your email",
                ),
                const SizedBox(height: 10.0),
                ReusableButton(
                  buttonTitle: "Send",
                  function: () => _onSendEmail(context),
                ),
                const SizedBox(height: 10.0),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          SignInScreen.id, (route) => false);
                    },
                    child: Text("Back to Login", style: kBlueNavTextButton),
                  ),
                  const SizedBox(width: 10.0),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onSendEmail(BuildContext context) async {
    hideKeyboard(context);
    AuthMethods authMethods = AuthMethods();
    String email = _emailController.text.trim();
    Validation validation = Validation();
    bool validEmail = validation.isValidEmail(email);

    setState(() {
      emailValid = validEmail;
    });

    if (emailValid) {
      setState(() {
        inAsyncCall = true;
      });

      await authMethods.resetPasswordWithEmail(email, context);

      setState(() {
        inAsyncCall = false;
      });

    }
  }
}
