import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_lo/client/homeClient.dart';
import 'package:trip_lo/client/signup.dart';

import '../services/authentication.dart';
import '../utils.dart';

class clientLogin extends StatefulWidget {
  const clientLogin({Key? key}) : super(key: key);

  @override
  State<clientLogin> createState() => _clientLoginState();
}

class _clientLoginState extends State<clientLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => homeClient(),
          ),
          (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  "        TripLy\n    Welcomes \n        You",
                  style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      labelStyle: TextStyle(
                        height: 3,
                      ),
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: 'Please enter a valid Email',
                      labelText: 'Enter Your Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        focusColor: Colors.white,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        labelStyle: TextStyle(
                          height: 3,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        hintText: 'Please enter your password',
                        labelText: 'Enter a valid password'),
                    obscureText: true,
                    controller: _passwordController,
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        elevation: 10,
                        shape: StadiumBorder(
                            side: BorderSide(
                                width: 2, color: Colors.deepOrange))),
                    onPressed: loginUser,
                    child: Text(
                      'LogIn',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Dont have an account?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => clientSignup()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
