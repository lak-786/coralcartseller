
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coralcartseller/services/firebase_add_product.dart';
import 'package:coralcartseller/services/firebase_auth_services.dart';
import 'package:coralcartseller/utils/helper.dart';
import 'package:coralcartseller/widgets/custom_button.dart';
import 'package:coralcartseller/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class editScreen extends StatefulWidget {
   editScreen({super.key,required this.shopname,required this.email,required this.phone,required this.address});

  String shopname;
  String email;
  String phone;
  String address;
  


  @override
  State<editScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<editScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController shopNameController= TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
    
    shopNameController.text = widget.shopname;
    emailController.text=widget.email;
    phoneController.text=widget.phone;
    addressController.text=widget.address;
    
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit profile',
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
                    controller: shopNameController,
                    hintText: 'shop Name',
                    label: 'shop name',
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
                    controller: emailController,
                    hintText: 'enter your email ',
                    label: 'email',
                    input: TextInputType.emailAddress,
                    validate: (value) {
                      return value == null ? 'required field' : null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    hintText: 'enter phonenumber ',
                    label: 'phonenumber',
                    validate: (value) {
                      return value == null ? 'required field' : null;
                    },
                    
                  ),
                   SizedBox(
                    height: 20,
                  ),

                   CustomTextField(
                    controller: addressController,
                    hintText: 'enter your address ',
                    label: 'Address',
                    input: TextInputType.streetAddress,
                    validate: (value) {
                      return value == null ? 'required field' : null;
                    },
                  ),
                 
                  SizedBox(
                    height: 20,
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
                            buttonName: 'Done',
                            onPressed: () async {
                              try {
                                setState(() {
                                  _loading = true;
                                });
                                await FirebaseAuthService().editprofile(
                                  
                                
                                   
                                    shopname: shopNameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    address:addressController.text,);
                                
                                Navigator.pop(context);
                                _loading = false;
                                MotionToast.success(
                                  title: Text("Success"),
                                  description: Text("Edit Successfully"),
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
