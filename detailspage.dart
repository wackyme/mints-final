 import 'dart:async';

import 'package:flutter/material.dart';
 import 'home.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:firebase_core/firebase_core.dart';

class DetailsPage extends StatefulWidget {
  String title, image,content;

  DetailsPage(
      {this.title,
      this.image,
      this.content,
      });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  StreamSubscription<QuerySnapshot>subscription;

  List<DocumentSnapshot>snapshot;

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mints");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[
            Image.network(
              widget.image,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 350.0, 0.0, 0.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  borderRadius: BorderRadius.circular(35.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          widget.content,
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
