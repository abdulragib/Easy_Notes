import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class addNote extends StatefulWidget {
  const addNote({Key? key}) : super(key: key);

  @override
  _addNoteState createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  late String title;
  late String des;

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');
    var data = {
      "title": title,
      'description': des,
      'created': DateTime.now(),
    };
    ref.add(data);
    //
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back_ios_outlined, size: 24.0),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[700],
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 8.0),
                    ),
                  ),
                ),
                //
                ElevatedButton(
                  onPressed: add,
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[700],
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Form(
                child: Column(
              children: <Widget>[
                TextFormField(
                    decoration: const InputDecoration.collapsed(
                      hintText: "Title",
                    ),
                    style: const TextStyle(
                        fontSize: 32.0,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    onChanged: (_val) {
                      title = _val;
                    }),
                //
                const SizedBox(
                  height: 10,
                ),
                //
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextFormField(
                    decoration: const InputDecoration.collapsed(
                      hintText: "Note Description",
                    ),
                    style: const TextStyle(
                        fontSize: 20.0, fontFamily: 'lato', color: Colors.grey),
                    onChanged: (_val) {
                      des = _val;
                    },
                    maxLines: 20,
                  ),
                ),
              ],
            ))
          ]),
        )),
      ),
    );
  }
}
