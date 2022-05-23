import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_lo/client/clientlogin.dart';
import 'package:trip_lo/client/homeClient.dart';

import 'package:trip_lo/services/authentication.dart';
import 'package:trip_lo/utils.dart';

class clientSignup extends StatefulWidget {
  const clientSignup({Key? key}) : super(key: key);

  @override
  _clientSignupState createState() => _clientSignupState();
}

class _clientSignupState extends State<clientSignup> {
  //show picker function
  GoogleMapController? newgooglecontroller;

  double lati = 0;
  double long = 0;
  var geoLocator = Geolocator();

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    //
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();

    lati = position.latitude;
    long = position.longitude;
    return position;
  }

  Uint8List? _image;
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _numbercontroller = TextEditingController();
  String job = "";
  String dropdownValue = "Guide";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "        TripLy\n Welcomes You",
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
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                        backgroundColor: Colors.red,
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                        backgroundColor: Colors.red,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.boy,
                    ),
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
                    hintText: 'Your Name goes here',
                    labelText: 'UserName'),
                controller: _namecontroller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.add_ic_call,
                  ),
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
                  hintText: 'Number',
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.number,
                controller: _numbercontroller,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You Are a ",
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      //  icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(
                          color: Colors.deepOrange, fontSize: 28),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Guide', 'Traveller']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    elevation: 10,
                    shape: StadiumBorder(
                        side: BorderSide(width: 2, color: Colors.deepOrange))),
                onPressed: () async {
                  await _determinePosition();

                  String res = await AuthMethods().signupClient(
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: _namecontroller.text,
                    number: _numbercontroller.text,
                    file: _image!,
                    lat: lati,
                    long: long,
                    job: dropdownValue,
                  );

                  print(res);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => homeClient()),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Already have an account?',
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
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => clientLogin()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
