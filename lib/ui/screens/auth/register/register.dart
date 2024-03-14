import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_mon_c10/model/my_user.dart';
import 'package:todo_mon_c10/ui/screens/home/home.dart';
import 'package:todo_mon_c10/ui/utils/dialog_utils.dart';

class Register extends StatelessWidget {
  static const String routeName = 'register';
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              TextFormField(
                controller: userNameController,
                decoration: const InputDecoration(labelText: "User name"),
                validator: (text) {
                   if(text == null || text.trim().isEmpty){
                     return 'Please enter a valid username';
                   }
                   return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return 'Empty email are not allowed';
                  }
                  bool isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if(!isEmailValid){
                    return 'Email format is wrong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (text) {
                  if(text == null || text.isEmpty){
                   return 'Please enter a password';
                  }
                  if(text.length < 6){
                    return 'Passwords should be more 6';
                  }
                },
              ),
              TextFormField(
                controller: rePasswordController,
                decoration: const InputDecoration(labelText: "Re-Password"),
                validator: (text) {
                  if(text == null || text.isEmpty){
                    return 'Please enter a password';
                  }
                  if(text != passwordController.text){
                    return '2 passwords does not match';
                  }
                },
              ),
              const Spacer(
                flex: 3,
              ),
              ElevatedButton(
                  onPressed: () {
                    register(context);
                  },
                  child: const Row(
                    children: [
                      Text("Create account"),
                      Spacer(),
                      Icon(Icons.arrow_right)
                    ],
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void register(BuildContext context) async {
    // if(!formKey.currentState!.validate()) return;
    try{
      DialogUtils.showLoading(context);
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      MyUser user = MyUser(id: credential.user!.uid,
          email: emailController.text,
          username: passwordController.text);
      registerUserToFireStore(user);
      DialogUtils.hideLoading(context);
      Navigator.pushNamed(context, Home.routeName);
    }on FirebaseAuthException catch(exception){
      DialogUtils.hideLoading(context);
      DialogUtils.showError(context,exception.message ?? "Something went wrong please try again later");
    }


  }

  void registerUserToFireStore(MyUser user) {
   CollectionReference collectionReference =
   FirebaseFirestore.instance.collection(MyUser.collectionName);
   collectionReference.doc(user.id).set(user.toJson());
  }
}
