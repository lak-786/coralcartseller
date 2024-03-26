import 'package:coralcartseller/services/firebase_auth_services.dart';
import 'package:coralcartseller/utils/helper.dart';
import 'package:coralcartseller/widgets/custom_button.dart';
import 'package:coralcartseller/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
          title: Text(
            'Register',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(

          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: 40,
              ),
              CustomTextField(
                controller: shopNameController,
                hintText: 'Enter shop name',
                label: 'Shop name',
                validate: (value) {
                  if (value!.isEmpty) {
                    return "fill the name";
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextField(
                controller: addressController,
                hintText: 'Enter your Address',
                label: 'Address',
                validate: (value) {
                  if (value!.isEmpty) {
                    return "fill the address";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: emailController,
                hintText: 'enter your email ',
                label: 'Email',
                validate: (value) {
                  return validateMail(value!);
                },
              ),



              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: phoneController,
                hintText: 'enter phone number',
                label: 'Phone',
                validate: (value) {
                  if (value!.isEmpty) {
                    return "fill the phone";
                  }
                },
              ),

              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                label: 'Password',
                validate: (value) {
                  return validatePassword(value!);
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'confirm password',
                label: 'Confirm password',
                validate: (value) {
                  if (value!.isNotEmpty) {
                    if (passwordController.text != value) {
                      

                      return "password miss match";
                    }
                  } else {
                    return "fill the name";
                  }
                },
              ),
              _loading ? Center(child:CircularProgressIndicator(color: Colors.teal,),):
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20 ),
            child:   CustomButton(buttonName: 'Register', onPressed: registerHandler)
              )
            ]),
          ),
        ));
  }

  void registerHandler() async{
    if (_formKey.currentState!.validate()) {
     FirebaseAuthService firebaseAuthService = FirebaseAuthService();
     try{
      setState(() {
          _loading= true;
        });
       await firebaseAuthService.register(
      name:shopNameController.text ,
      address:addressController.text,
      password: passwordController.text,
      phoneNumber: phoneController.text,
      email: emailController.text, 
    );
    _loading = false;

        MotionToast.success(
          title: Text("Success"),
          description: Text("Registration Successful"),
        ).show(context);

        Navigator.pop(context);
      } catch (e) {
        setState(() {
          _loading = false;
        });
        String error = getFirebaseAuthErrorMessage(e);

        MotionToast.warning(
                title: Text("Warning"), 
                description: Text(error))
            .show(context);
     }
    }
  }
}
 
