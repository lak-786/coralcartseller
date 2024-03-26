import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Set app bar background color to teal
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        actions: [ 
          IconButton(
            icon: Icon(Icons.shopping_cart,
                color: Colors.white), // Set icon color to white
            onPressed: () {
              // Navigate to the cart screen
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CartItemTile(
            productName: 'Product 1',
            price: 10.0,
            imageUrl: 'https://via.placeholder.com/150',
          ),
          SizedBox(height: 16),
          CartItemTile(
            productName: 'Product 2',
            price: 20.0,
            imageUrl: 'https://via.placeholder.com/150',
          ),
          SizedBox(height: 16),
          CartItemTile(
            productName: 'Product 3',
            price: 30.0,
            imageUrl: 'https://via.placeholder.com/150',
          ),
          SizedBox(height: 16),
          CartItemTile(
            productName: 'Product 3',
            price: 30.0,
            imageUrl: 'https://via.placeholder.com/150',
          ),
          SizedBox(height: 16),
          CartItemTile(
            productName: 'Product 3',
            price: 30.0,
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final String productName;
  final double price;
  final String imageUrl;

  const CartItemTile({
    required this.productName,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(productName),
        subtitle: Text('Price: \$${price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Colors.black, // Set icon color to black
          onPressed: () {
            // Implement logic to remove item from cart
          },
        ),
      ),
    );
  }
}
