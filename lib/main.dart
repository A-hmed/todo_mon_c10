import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c10/ui/provider/list_provider.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyCQYhykBPmsozzCjmBbskRDVaalE3atgWM",
        appId: "todo-mon-c10",
        messagingSenderId: "todo-mon-c10",
        projectId: "todo-mon-c10"),
  );
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(ChangeNotifierProvider(
      create: (_) => ListProvider(),
      child: const MyApp()));
}

