// import 'package:cbsbeta01/auth/customer_signup.dart';
import 'package:cbsbeta01/widgets/auth_widgets.dart';
import 'package:cbsbeta01/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class SupplierLogin extends StatefulWidget {
  const SupplierLogin({Key? key}) : super(key: key);

  @override
  State<SupplierLogin> createState() => _SupplierLoginState();
}

class _SupplierLoginState extends State<SupplierLogin> {

  late String email;
  late String password;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;

  void login() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        _formKey.currentState!.reset();

        Navigator.pushReplacementNamed(context, '/supplier_home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldKey, 'No user found for that email');
        } else if (e.code == 'wrong-password') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldKey, 'Wrong password ');
        }
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessageHandler.showSnackBar(_scaffoldKey, 'Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthHeaderLabel(
                        headerLabel: 'Log In',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            } else if (value.isValidEmail() == false) {
                              return 'invalid email';
                            } else if (value.isValidEmail() == true) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          // controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration.copyWith(
                              labelText: 'Email Address',
                              hintText: 'Enter your email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            password = value;
                          },
                          // controller: _passwordController,
                          obscureText: passwordVisible,
                          decoration: textFormDecoration.copyWith(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.purple,
                                  )),
                              labelText: 'Password',
                              hintText: 'Enter your Password'),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic),
                          )),
                      HaveAccount(
                        haveAccount: 'Don\'t have Account? ',
                        actionLabel: 'Sign Up',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/supplier_signup');
                        },
                      ),
                      processing == true
                          ? const Center(child: CircularProgressIndicator(color: Colors.purple,))
                          : AuthMainButton(
                        mainButtonLabel: 'Log In',
                        onPressed: () {
                          login();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
