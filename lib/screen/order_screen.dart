import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List orderList = [];
  List ordersProductList = [];

  final fireStore = FirebaseFirestore.instance;

  bool loading = false;

  @override
  void initState() {
    getSellerIdsFromOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text(
            'Cart',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ordersProductList.isEmpty
                ? Text('No data')
                : ListView.builder(
                    itemCount: ordersProductList.length,
                    itemBuilder: (context, index) {
                      // Access the data from each document and pass it to the CartItemTile
                      Map<String, dynamic> orderData = ordersProductList[index];

                     
                      return CartItemTile(
                        productName: orderData['productname'],
                        price: orderData['subtotal'],
                      );
                    },
                  ));
  }

  Future<void> getSellerIdsFromOrders() async {
    try {
    

      setState(() {
        loading = false;
      });
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await fireStore.collection('orders').get();

      snapshot.docs.forEach((doc) {
        
        List productlist = doc['productlist'];
    
        productlist.forEach((element) {
          if (element['sellerid'] == FirebaseAuth.instance.currentUser!.uid) {
          
       
            ordersProductList.add(element);
            orderList.add(doc.id);

           
          }
        });
      });

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }
}

class CartItemTile extends StatelessWidget {
  final String productName;
  final String price;

  const CartItemTile({
    super.key,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(productName),
        subtitle: Text('Price: \$${price}'),
        trailing: ElevatedButton(
          onPressed: () {



          },
          child: Text(
            'Details',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, // Background color

            padding: EdgeInsets.symmetric(
                vertical: 12, horizontal: 24), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Button border radius
            ),
          ),
        ),
      ),
    );
  }
}
