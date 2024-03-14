import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_mon_c10/model/my_user.dart';
import 'package:todo_mon_c10/ui/screens/auth/register/register.dart';
import 'package:todo_mon_c10/ui/screens/home/home.dart';
import 'package:todo_mon_c10/ui/utils/dialog_utils.dart';

class Login extends StatelessWidget {
  static const String routeName = 'login';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
              const Spacer(
                flex: 3,
              ),
              ElevatedButton(
                  onPressed: () {
                    login(context);
                  },
                  child: const Row(
                    children: [
                      Text("Log in"),
                      Spacer(),
                      Icon(Icons.arrow_right)
                    ],
                  )),
              InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, Register.routeName);
                  },
                  child: Text("Do not have an account ? Create account")),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    // if(!formKey.currentState!.validate()) return;
    try{
      DialogUtils.showLoading(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      getUserFromFireStore(credential.user!.uid);
      DialogUtils.hideLoading(context);
      Navigator.pushNamed(context, Home.routeName);

    }on FirebaseAuthException catch(exception){
      DialogUtils.hideLoading(context);
      DialogUtils.showError(context,exception.message ?? "Something went wrong please try again later");
    }
  }
  Future<MyUser> getUserFromFireStore(String id) async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(MyUser.collectionName);
    DocumentReference docRef = collectionReference.doc(id);
    DocumentSnapshot docSnapshot = await docRef.get();
   Map json = docSnapshot.data() as Map;
   return MyUser.fromJson(json);
  }
}
