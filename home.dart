import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'detailspage.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';




class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  StreamSubscription<QuerySnapshot>subscription;

  List<DocumentSnapshot>snapshot;

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mints");

  @override
  void initState() {
    subscription = collectionReference.snapshots().listen((datasnap) { 
      setState(() {
        snapshot = datasnap.docs;
      });
    });
    super.initState();
     
  }
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Mints"),
        backgroundColor: Colors.teal[200],
      ),

      drawer: Drawer(
        child:Container(
            color: Colors.teal[200],
            child: ListView(
            children:<Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("CONTACT US AT"), 
                accountEmail: Text("mintslpu@gmail.com"),
                decoration: BoxDecoration(color: Colors.black),
                )
            ]
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return InkWell( onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                    title: snapshot[index].data()['title'] ,
                                    content: snapshot[index].data()["content"],
                                    image:snapshot[index].data()['image'] ,
                                  )));
                    },
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0),
                        ),
                        child: Image.network(
                          snapshot[index].data()['image'] ,
                          fit: BoxFit.cover,
                          height: 400.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 350.0, 0.0, 0.0),
                      child: Container(
                        height: 200.0,
                        width: 400.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(35.0),
                          elevation: 10.0,
                          child: Column(
                            children:<Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 20.0),
                                child: Text(
                                  snapshot[index].data()['title'] ,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ]
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            );
          },
          itemCount: snapshot == null ? 0 : snapshot.length, autoplay: true,viewportFraction: 0.8,
                scale: 0.9,
        ),
      )
    );
  }
}