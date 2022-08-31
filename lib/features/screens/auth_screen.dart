import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';

import 'package:flutter/material.dart';

import '../services/auth_service.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final AuthService authService = AuthService();
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void signupUser() {
    authService.signUpUser(
        context: context,
        email: emailController.text,
        password: passController.text,
        name: nameController.text);
  }
 void signinUser() {
    authService.signInUser(
        context: context,
        email: emailController.text,
        password: passController.text,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text('Create Account'),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(
                      () {
                        _auth = val!;
                      },
                    );
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  color: GlobalVariables.backgroundColor,
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(children: [
                      CustomTextfield(
                        controller: nameController,
                        hintText: "Name",
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      CustomTextfield(
                        controller: emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      CustomTextfield(
                        controller: passController,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      CustomButton(
                          text: "SignUp",
                          onTap: () {
                         if(_signUpFormKey.currentState!.validate()){
                          signupUser();
                        }
                          })
                    ]),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text('Sign-In'),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(
                      () {
                        _auth = val!;
                      },
                    );
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  color: GlobalVariables.backgroundColor,
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _signInFormKey,
                    child: Column(children: [
                      CustomTextfield(
                        controller: emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      CustomTextfield(
                        controller: passController,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      CustomButton(text: "SignIn", onTap: () {
                        if(_signInFormKey.currentState!.validate()){
                          signinUser();
                        }
                      })
                    ]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
