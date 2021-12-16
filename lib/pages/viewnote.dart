import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref, {Key? key}) : super(key: key);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  var title;
  var des;
  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  void delete() async {
    //delete from db
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {
    //TODO: showing any kind of alert that new changes have been saved
    if (key.currentState!.validate()) {
      await widget.ref.update(
        {'title': title, 'description': des},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];
    des = widget.data['des'];
    return SafeArea(
      child: Scaffold(
        floatingActionButton: edit
            ? FloatingActionButton(
                onPressed: save,
                child: const Icon(Icons.save_rounded, color: Colors.white70),
                backgroundColor: Colors.grey[700],
              )
            : null,
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
                      child:
                          const Icon(Icons.arrow_back_ios_outlined, size: 24.0),
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
                    Row(children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit;
                          });
                        },
                        child: const Icon(
                          Icons.edit,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[500],
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                          ),
                        ),
                      ),
                      //
                      const SizedBox(
                        width: 10.0,
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
                            const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
                const SizedBox(height: 12.0),
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          initialValue: widget.data['title'],
                          enabled: edit,
                          onChanged: (_val) {
                            title = _val;
                          },
                          validator: (_val) {
                            if (_val!.isEmpty) {
                              return "Can't be empty";
                            } else {
                              return null;
                            }
                          }),

                      //
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
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
                      TextFormField(
                          decoration: const InputDecoration.collapsed(
                            hintText: "Note Description",
                          ),
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'lato',
                              color: Colors.grey),
                          initialValue: widget.data[
                              'description'], //default of this textformfield
                          enabled:
                              edit, // when we click on edit button then only able to change description data
                          onChanged: (_val) {
                            des = _val;
                          },
                          maxLines: 20,
                          validator: (_val) {
                            if (_val!.isEmpty) {
                              return "Can't be empty";
                            } else {
                              return null;
                            }
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//bydefault title and descrption will be null and if we to change only title not description then updation will not done
//so we need grap original value of  title and description from firebase in scaffold so will not null.

// GlobalKey<FormState> key = GlobalKey<FormState>(); we are using it bcz let suppose we open any note and we clearing text of it, technically we are delting it but we dont want this
//we want  to delete any note by clicking on delete button.