import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coralcartseller/screen/edit_profile.dart';
import 'package:coralcartseller/services/firebase_auth_services.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('sellerRegistration')
              .doc(FirebaseAuthService().getSellerId())
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Loading indicator while waiting for data
            }
           

            var profileData = snapshot.data?.data();
            print(profileData);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Placeholder image
                  ),
                  SizedBox(height: 20),
                  Text(
                    profileData!['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildInfoItem(context, 'Email', profileData!['email']),
                  _buildInfoItem(context, 'Phone', profileData['phoneNumber']),
                  _buildInfoItem(context, 'Address', profileData['address']),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => editScreen(shopname: profileData['name'],email: profileData['email'],phone:profileData['phoneNumber'],address: profileData['address'],),));// Add functionality for editing profile
                    },
                    child: Text('Edit Profile'),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _buildInfoItem(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
