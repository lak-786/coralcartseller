
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coralcartseller/services/firebase_add_product.dart';
import 'package:coralcartseller/utils/helper.dart';
import 'package:coralcartseller/widgets/custom_button.dart';
import 'package:coralcartseller/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class UpdateScreen extends StatefulWidget {
   UpdateScreen({super.key,required this.productId,required this.productname,required this.price,required this.discription,required this.category,required this.image});
  String productId;
  String image;
  String productname;
  String price;
  String discription;
  String category;


  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController ProductNameController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();

  bool _loading = false;
  File? _imageFile;

  DocumentSnapshot? _selectedCategory;
  // State variable for dropdown value

  Future<void> _pickImageFromGallery() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePicture() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              CustomButton(
                buttonName: 'Choose from Gallery',
                onPressed: _pickImageFromGallery,
              ),
              CustomButton(
                buttonName: 'Take a Picture',
                onPressed: _takePicture,
              ),
              CustomButton(
                buttonName: 'Cancel',
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet on cancel
                },
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  void initState() {
    
    PriceController.text = widget.price;
    ProductNameController.text=widget.productname;
    discriptionController.text=widget.discription;
    
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Update Page',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  _imageFile == null
                      ? 

                     
                      
                      
                       
                      Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: 250,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    widget.image,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Positioned(
                              top: 0,
                              right: 20,
                              child: IconButton(
                                  onPressed: () {
                                    _showImagePickerModal();
                                  },
                                  icon: Icon(
                                    Icons.update,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        )
                  
                  
                  
                     
                     
                      : 
                      
                      Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: 250,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Positioned(
                              top: 0,
                              right: 20,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _imageFile = null;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                  
                  
                  
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: ProductNameController,
                    hintText: 'Product Name',
                    label: 'Product name',
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "fill the name";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: PriceController,
                    hintText: 'enter price ',
                    label: 'Price',
                    input: TextInputType.number,
                    validate: (value) {
                      return value == null ? 'required field' : null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: discriptionController,
                    hintText: 'add your discription',
                    label: 'Discription',
                    validate: (value) {
                      return value == null ? 'required field' : null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('category')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Loading indicator while waiting for data
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButtonFormField<DocumentSnapshot>(
                          value: _selectedCategory,
                          onChanged: (DocumentSnapshot? newValue) {
                            _selectedCategory = newValue;
                          },
                          items: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            var data = document.data() as Map<String, dynamic>;
                            return DropdownMenuItem<DocumentSnapshot>(
                              value: document,
                              child: Text(data['category']),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  _loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.teal,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomButton(
                            buttonName: 'Update',
                            onPressed: () async {
                              try {
                                setState(() {
                                  _loading = true;
                                });
                                await FirebaseProductService().updateProduct(
                                  id: widget.productId,
                                    image: _imageFile!,
                                    productname: ProductNameController.text,
                                    price: PriceController.text,
                                    discription: discriptionController.text,
                                    category:  _selectedCategory!.get('category'),
                                    catId: _selectedCategory!.id);
                                Navigator.pop(context);
                                _loading = false;
                                MotionToast.success(
                                  title: Text("Success"),
                                  description: Text("Update Successful"),
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
                ]))));
  }
} 
