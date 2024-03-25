



import 'package:coralcartseller/firebase_options.dart';
import 'package:coralcartseller/screen/home_screen.dart';
import 'package:coralcartseller/screen/login_screen.dart';
import 'package:coralcartseller/screen/order_screen.dart';
import 'package:coralcartseller/screen/profile_screen.dart';
import 'package:coralcartseller/screen/root_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home:LoginScreen()
      
      ),
    );
  

}
