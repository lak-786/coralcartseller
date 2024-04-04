import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coralcartseller/screen/root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseStore = FirebaseFirestore.instance;
  Future<void> register({
    required String name,
    required String address,
    required String password,
    required String phoneNumber,
    required String email,
  }) async {
    try {
      // Create user with Firebase Authentication
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = userCredential.user;

      await _firebaseStore.collection('sellerRegistration').doc(user!.uid).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'address': address,
        'status' : 'pending'
      });
      print('================================================================');
      await _firebaseStore.collection('logintb').doc(user.uid).set({
        'userid': user.uid,
        'email': email,
        'password': password,
        'status': 'pending',
        'role': 'seller'
      });
    } catch (e) {
      print(e);

      rethrow;
    }

    Future<void> login(
        {required String email, required String password}) async {
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } catch (e) {
        rethrow;
      }
    }
  }
  Future<void> login({required String email, required String password ,required BuildContext context}) async {
    try {
     UserCredential ? user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(user.user! );

     

     if(user != null){
      print('hhhhhh');

      var isSellerValid = await _firebaseStore.collection('sellerRegistration').doc(user.user!.uid).get();

      var isApprove = isSellerValid.get('status');

      print(isApprove);

      if(isApprove == 'completed'){

        MotionToast.success(
          title: Text("Success"),
          description: Text("Login Successful"),
        ).show(context);

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => RootScreen(),
              ),
              (route) => false);
        }


      }else{

        MotionToast.warning(
          title: Text("Warning"),
          description: Text("waiting for admin approvel"),
        ).show(context);


      }
     }



    } catch (e) {
      rethrow;
    }
  }

  String getSellerId() {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<void> editprofile(
      {required String shopname,
      required String email,
      required String phone,
      required String address}) async {
    try {
      _firebaseStore
          .collection('sellerRegistration')
          .doc(getSellerId())
          .update({
        'name': shopname,
        'email': email,
        'phoneNumber': phone,
        'address': address
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

   Future<Map<String,dynamic>?>  getUser()async {

    var data = await _firebaseStore.collection('sellerRegistration').doc(getSellerId()).get();
    return data.data();

    
  }
}
