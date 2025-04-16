// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:finance_management/screens/login.dart';
import 'package:finance_management/services/auth_service.dart';
import 'package:finance_management/utils/appvalidator.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();

  final _emailController = TextEditingController();

  // final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  var authService = AuthService();
  var isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      var data = {
        "username": _userNameController.text,
        "email": _emailController.text,
        // "phone": _phoneController.text,
        "password": _passwordController.text,
        'remainingAmount': 0,
        'totalCredit':0,
        'totalDebit': 0,
      };

      await authService.createUser(data, context);
      
      setState(() {
        isLoader = false;
      });

      // ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
      //   const SnackBar(content: Text('Sign Up Successful.')),
      // );
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252634),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                const SizedBox(
                  width: 250,
                  child: Text(
                    'Create new Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                    controller: _userNameController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.white),
                    decoration: _buildInputDecoration('UserName', Icons.person),
                    validator: appValidator.validateUsername),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Email Id', Icons.email),
                  validator: appValidator.validateEmail,
                ),
                const SizedBox(height: 16),
                // TextFormField(
                //   controller: _phoneController,
                //   keyboardType: TextInputType.phone,
                //   style: const TextStyle(color: Colors.white),
                //   decoration:
                //       _buildInputDecoration('Phone Number', Icons.phone),
                //   validator: appValidator.validatePhoneNumber,
                // ),
                // const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Password', Icons.password),
                  validator: appValidator.validatePassword,
                ),
                const SizedBox(height: 40),
                SizedBox(
                    height: 60,
                    width: 300,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: const Color.fromARGB(255, 255, 217, 0),
                        onPressed: () {
                          isLoader ? print("Loading") : _submitForm();
                        },
                        child: isLoader
                            ? const Center(
                                child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ))
                            : const Text(
                                'CREATE',
                                style: TextStyle(fontSize: 20),
                              ))),
                const SizedBox(height: 30),
                const Text("Already have an Account ?",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 16)),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const LoginView()));
                    },
                    child: const Text('Login',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 217, 0),
                            fontSize: 20))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
        fillColor: const Color(0xAA494A59),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF949494)),
            borderRadius: BorderRadius.circular(25)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF949494)),
            borderRadius: BorderRadius.circular(25)),
        filled: true,
        labelStyle: const TextStyle(color: Colors.white),
        labelText: label,
        suffixIcon: Icon(
          suffixIcon,
          color: const Color(0xFF949494),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)));
  }
}
