import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class profileClient extends StatefulWidget {
  profileClient({Key? key, required this.uid}) : super(key: key);
  String uid;
  @override
  _profileClientState createState() => _profileClientState();
}

class _profileClientState extends State<profileClient> {
  String name = "";
  String number = "";
  String url = "";
  String job = "";

  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection('client')
        .doc(user!.uid)
        .get();
    setState(() {
      name = vari.data()!['name'];
      number = vari.data()!['number'];
      url = vari.data()!['photoUrl'];
      job = vari.data()!['job'];
    });
    print(name);
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //appBar: AppBar(title: Text(name)),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 100,
        ),
        CircleAvatar(
          backgroundColor: Colors.deepOrange,
          radius: 70,
          child: CircleAvatar(
            radius: 65,
            backgroundImage: NetworkImage(url),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 90,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                ),
                Icon(
                  Icons.account_box_rounded,
                  size: 50,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    name,
                    style: GoogleFonts.lobster(
                      textStyle: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 90,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                ),
                Icon(
                  Icons.badge_rounded,
                  size: 50,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  job,
                  style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 90,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                ),
                Icon(
                  Icons.add_ic_call,
                  size: 50,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  number,
                  style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
