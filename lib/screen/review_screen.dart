import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coralcartseller/services/firebase_add_product.dart';
import 'package:coralcartseller/services/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewViewScreen extends StatelessWidget {
  

  const ReviewViewScreen({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review'),
      ),
    
     body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Review')
            .where('sellerId', isEqualTo: FirebaseAuthService().getSellerId() )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final reviews = snapshot.data!.docs;
          if (reviews.isEmpty) {
            return Center(
              child: Text('No reviews found.'),
            );
          }
          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(review['userId']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review['review']),
                    RatingBarIndicator(
                      rating: review['rating'],
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
                       
                       
                       
  }
}


