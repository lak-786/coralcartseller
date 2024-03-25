

import 'dart:io';

import 'package:coralcartseller/screen/update_screen.dart';
import 'package:coralcartseller/services/firebase_add_product.dart';
import 'package:coralcartseller/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:motion_toast/motion_toast.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final String id;

  const ProductDetailsScreen({super.key, required this.data, required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Section: Image and Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  widget.data['image'],
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data['productname'],
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.data['price'], // Replace with your price
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.data['discription'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom Section: Buttons
        _loading ? Center(child: CircularProgressIndicator(),) :   Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonName: 'Update',
                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(productId: widget.id,productname: widget.data['productname'],price: widget.data['price'],discription: widget.data['discription'],category: widget.data['category'],image:widget.data['image']),));

                      
                      
                      // Add to Cart Logic
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    buttonName: 'Delete',
                    onPressed: () async {
                      try {
                        setState(() {
                          _loading = true;
                        });
                        await FirebaseProductService().deleteProduct(id: widget.id);
                        Navigator.pop(context);
                        _loading = false;
                        MotionToast.success(
                          title: Text("Success"),
                          description: Text("Delete Successful"),
                        ).show(context);
                      } catch (e) {
                        setState(() {
                          _loading = false;
                        });
                        MotionToast.warning(
                                title: Text("Warning"),
                                description: Text('Somthingwent wrong'))
                            .show(context);
                      }
                    },
                  ),
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
