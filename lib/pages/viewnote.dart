import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewNote extends StatefulWidget {

  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data,this.time,this.ref, {Key? key}) : super(key: key);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  late String title;
  late String des;

  void delete() async {

    //delete from db
    await widget.ref.delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                          const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
                        ),
                      ),
                    ),
                    //
                    ElevatedButton(
                      onPressed: delete,
                      child: const Icon(
                        Icons.delete_forever,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.red[300],
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "${widget.data['title']}",
                        style: const TextStyle(
                            fontSize: 32.0,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        ),

                    //
                    Padding(
                      padding: const EdgeInsets.only(top:12.0, bottom: 12.0),
                      child: Text(
                        widget.time,
                        style: const TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'lato',
                            color: Colors.grey),
                      ),
                    ),
                    //
                    const SizedBox(
                      height: 10.0,
                    ),
                    //
                    Container(
                      height: MediaQuery.of(context).size.height*0.75,
                      child: Text(
                        "${widget.data['description']}",
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'lato',
                            color: Colors.grey),
                      ),
                    ),
                  ],
                )
              ],),
            ),),
      ),
    );
  }
}
