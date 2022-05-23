import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_lo/services/storage.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String number,
    required Uint8List file,
    required double lat,
    required double long,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          number.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilepics', file);
        print(cred.user!.uid);

        _firestore.collection('guide').doc(cred.user!.uid).set({
          'name': username,
          'number': number,
          'photoUrl': photoUrl,
          'uid': cred.user!.uid,
          'lat': lat,
          'long': long,
        });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> signupClient({
    required String email,
    required String password,
    required String username,
    required String number,
    required Uint8List file,
    required double lat,
    required double long,
    required String job,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          number.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        cred.user!.updateDisplayName(username);
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilepics', file);
        print(cred.user!.uid);

        _firestore.collection('client').doc(cred.user!.uid).set({
          'name': username,
          'number': number,
          'photoUrl': photoUrl,
          'uid': cred.user!.uid,
          'lat': lat,
          'long': long,
          'job':job,
          'email':email,
        });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
