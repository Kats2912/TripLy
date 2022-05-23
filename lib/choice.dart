import 'package:flutter/material.dart';
import 'package:trip_lo/client/signup.dart';


class Choice extends StatelessWidget {
  Choice({Key? key}) : super(key: key);
  bool guide = false;
  bool client = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://images-na.ssl-images-amazon.com/images/I/41nM6xeg3yL._SX331_BO1,204,203,200_.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: null /* add child content here */,
      ),
      floatingActionButton: SizedBox(
          height: 50.0,
          width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.deepOrange,
            child: Text('Signup/Login'),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>clientSignup()),
              );
            },
          ),
        ),
      )
    );
  }
}
/*
class stream extends StatelessWidget {
  const stream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // Checking if the snapshot has any data or not
            if (snapshot.hasData&&guide) {
              // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
              return const Home();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          // means connection to future hasnt been made yet
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

         
        },
      );
  }
}*/
