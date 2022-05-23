import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_lo/chat/ct.dart';

import 'package:trip_lo/client/mapsClient.dart';
import 'package:trip_lo/client/othersClient.dart';
import 'package:trip_lo/client/profileClient.dart';

class homeClient extends StatefulWidget {
  const homeClient({Key? key}) : super(key: key);

  @override
  _homeClientState createState() => _homeClientState();
}

class _homeClientState extends State<homeClient> {
  int index = 0;
  List screens = [
    mapsClient(),
    ct(),
    profileClient(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
    othersClient(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: new Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
            child: new Text(
              'TripLy',
              style: new TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: [Colors.red, Colors.yellow]),
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                )
              ]),
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
      ),
      body: Center(
        child: screens.elementAt(index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Track'),
          BottomNavigationBarItem(
              icon: Icon(Icons.announcement), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Others'),
        ],
        currentIndex: index,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: (int Index) {
          setState(() {
            index = Index;
          });
        },
      ),
    );
  }
}
