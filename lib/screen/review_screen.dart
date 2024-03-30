import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<String> reviews = [
    "Great product!",
    "Excellent service!",
    "Needs improvement.",
  ]; // Sample list of reviews, you can replace it with your data source

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(reviews[index]),
            // Optionally, you can add other details like date, user info, etc.
          );
        },
      ),
     
    );
  }
}

class AddReviewPage extends StatefulWidget {
  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: reviewController,
              decoration: InputDecoration(
                labelText: 'Write your review',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add the review to the list and navigate back to the review page
                setState(() {
                  // Assuming the review is valid and you want to add it
                  String newReview = reviewController.text;
                  if (newReview.isNotEmpty) {
                    // Add the new review to the list
                    // You can replace this logic with your actual review submission process
                    Navigator.pop(context, newReview);
                  }
                });
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
