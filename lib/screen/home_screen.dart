import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coralcartseller/screen/add_screen.dart';
import 'package:coralcartseller/screen/product_details.dart';
import 'package:coralcartseller/services/firebase_add_product.dart';
import 'package:coralcartseller/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('product').snapshots(),
              builder: (context,snapshot) {
                if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Loading indicator while waiting for data
                      }

                      var productData = snapshot.data!.docs;
                return GridView.builder(
                  gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 10, // Spacing between rows
                    crossAxisSpacing: 10, // Spacing between columns
                  ),
                  itemCount: productData.length, // Number of items in the grid
                  itemBuilder: (context, index) {
                    var data = productData[index].data();
                    return GestureDetector(
                      onTap: () {
                         
                        Navigator.push(context,MaterialPageRoute(builder: (context) => ProductDetailsScreen(data:data,id:productData[index].id ,)));
                      
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(color: Colors.teal, width: 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  data['image'],
                      
                                  fit: BoxFit.cover,
                                  width: 200,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              data['productname'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomButton(
            buttonName: 'Add',
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AddScreen(),));
          
            },
          ),
        )
      ],
    );
  }
}

class CurvedBottomContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget logo;
  final Widget searchBar;

  const CurvedBottomContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.logo,
    required this.searchBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.teal, // Set container color to teal
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          logo,
          searchBar,
        ],
      ),
      
    );
  }
}
