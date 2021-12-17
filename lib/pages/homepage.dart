import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/pages/login.dart';
import 'package:note_app/pages/viewnote.dart';
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

  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => addNote(),
            ),
          )
              .then((value) {
            // when addNote take will done after that then((value){}) will called with future value.
            print("Calling Set State !");
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.white38,
      ),
      //
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(
              fontSize: 20.0, fontFamily: 'lato', color: Colors.white70),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff070706),
        actions: [
          InkWell(
            onTap: _signOut,
            child: const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                "Sign out",
                style: TextStyle(
                    fontSize: 17.0, fontFamily: 'lato', color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
      //
      body: FutureBuilder<QuerySnapshot>(
        // future builder used to fetch dynamic data which we fetch from firebase
        future: ref.get(),
        // future take snapsort of documents and use to execute function which return return result in future
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //
            if (snapshot.data?.docs.length == 0) {
              return const Center(
                child: Text(
                  "You have no saved Notes!",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
              );
            }
            //
            return ListView.builder(
              // used to return anykind of data in scrollable list format
              itemCount: snapshot.data?.docs.length,
              //couting how many docs in notes collection
              itemBuilder: (context, index) {
                Random random =
                    Random(); // Random() comes from dart.math package and use to generate random number
                Color bg = myColors[random
                    .nextInt(4)]; //nextInt used to creates non-negative integer
                Map? data = snapshot.data?.docs[index].data()
                    as Map?; // data() used to get data like title and description from document
                DateTime mydateTime =
                    data?['created'].toDate(); //fetching time from firebase
                String formattedTime =
                    DateFormat.yMMMd().add_jm().format(mydateTime);

                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ViewNote(data!, formattedTime,
                            snapshot.data!.docs[index].reference),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    color: bg,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${data?['title']}",
                            style: const TextStyle(
                                fontSize: 24.0,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          //
                          const SizedBox(
                            height: 3.0,
                          ),
                          //
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattedTime,
                              style: const TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: 'lato',
                                  color: Colors.black87),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}

//snapshot.data?.docs[index].data() it is a object type data so we are coverting object to map format data
