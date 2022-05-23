import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class tripleagues extends StatefulWidget {
  const tripleagues({Key? key}) : super(key: key);

  @override
  State<tripleagues> createState() => _tripleaguesState();
}

class _tripleaguesState extends State<tripleagues> {
  CollectionReference _client = FirebaseFirestore.instance.collection('client');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: _client.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return SizedBox(
                  height: 120,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 34,
                        backgroundImage:
                            NetworkImage(documentSnapshot['photoUrl']),
                      ),
                      title: Text(
                        documentSnapshot['name'],
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        documentSnapshot['number'].toString(),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        documentSnapshot['job'],
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
    );
  }
}
