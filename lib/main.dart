import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String collectionName = 'test_collection';

  Future<void> addTestData() async {
    await FirebaseFirestore.instance.collection(collectionName).add({
      'name': 'Test Item',
      'timestamp': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase + Flutter')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await addTestData();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data added to Firestore!')),
            );
          },
          child: const Text('Add Test Data'),
        ),
      ),
    );
  }
}
