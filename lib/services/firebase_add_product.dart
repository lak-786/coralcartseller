import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coralcartseller/services/firebase_auth_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseProductService {
  final _firebaseStore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  

  Future<void> addProduct({
    required File image,
    required String productname,
    required String price,
    required String discription,
    required String category,
    required  String catId,

    
    }) async {
    try {
      String fileName= basename(image.path);
      Reference ref = _storage.ref().child('product/$fileName');

      UploadTask uploadTask = ref.putFile(image);
      await uploadTask;
      String downloadURL = await ref.getDownloadURL();

_firebaseStore.collection('product').doc().set({
 'productname':productname,
  'price':price,
  'discription':discription,
  'category': category,
  'image': downloadURL,
  'catId' : catId,
  'sellerId':FirebaseAuthService().getSellerId()
  
}

);


      
    } catch (e) {
      rethrow;
    }
  }

Future<void> deleteProduct({
    required String id,
    
    }) async{
      try{

        _firebaseStore.collection('product').doc(id).delete();

      }
      catch(e)

      {
        rethrow;
      }

    }
    Future<void> updateProduct({
    required String id,
    required File image,
    required String productname,
    required String price,
    required String discription,
    required String catId,
    required String category,
    
    }) async{
      try{
        String fileName= basename(image.path);
        Reference ref = _storage.ref().child('product/$fileName');
         UploadTask uploadTask = ref.putFile(image);
      await uploadTask;
      String downloadURL = await ref.getDownloadURL();

        _firebaseStore.collection('product').doc(id).update({
           'image': downloadURL,
           'productname':productname,
           'price':price,
           'discription':discription,
        });

      }
      catch(e)

      {
        rethrow;
      }



    }

 
}
