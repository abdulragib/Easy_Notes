import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/addnote.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes');

  List myColors = [
    Colors.yellow[200],
    Colors.red[200],
    Colors.green[200],
    Colors.deepPurple[200],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => addNote(),
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.grey,
      ),
      body: FutureBuilder<QuerySnapshot>(
        // future builder used to fetch dynamic data which we fetch from firebase
        future: ref.get(),// future take snapsort of documents and use to execute function which return return result in future
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              // used to return anykind of data in scrollable list format
              itemCount: snapshot.data?.docs.length,
              //couting how many docs in notes collection
              itemBuilder: (context, index) {
                Random random = Random(); // Random() comes from dart.math package and use to generate random number
                Color bg= myColors[random.nextInt(4)];//nextInt used to creates non-negative integer
                Map? data = snapshot.data?.docs[index].data() as Map?; // data() used to get data like title and description from document
                return Card(
                  color: bg,
                  child: Column(
                    children: <Widget>[
                     Text(
                       "${data?['title']}",
                     )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}
