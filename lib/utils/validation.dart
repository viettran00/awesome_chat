class Validation{
  Validation();
  bool isValidEmail(String email){
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    bool emailValid = regExp.hasMatch(email);
    return emailValid;
  }

  bool isValidPassword(String password){
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    bool passwordValid = regExp.hasMatch(password);
    return passwordValid;
  }
}

/*


Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: FlutterLogo(size: 100)),
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
                  errorText: null,
                  hintText: "Please enter your name",
                ),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  errorText:
                      checkValidEmail ? null : "Your email is invalid",
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
                      hasSpecialCharacters = val
                          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
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
                        : Icon(Icons.visibility_off,
                            color: Colors.black),
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
                  errorText: checkValidRePassword
                      ? null
                      : "Password does not match",
                  prefixIcon: Icon(Icons.lock, color: Colors.blue),
                  suffixIcon: GestureDetector(
                    child: obscureTextRePassword
                        ? Icon(Icons.visibility, color: Colors.black)
                        : Icon(Icons.visibility_off,
                            color: Colors.black),
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
                            fontStyle: FontStyle.italic,
                            fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              SignInScreen.id, (route) => false);
                        },
                        child: Text("Login Now",
                            style: kBlueNavTextButton),
                      ),
                    ],
                  ),
                )
              ],
            )

*/