import 'package:coralcartseller/utils/helper.dart';
import 'package:coralcartseller/widgets/custom_button.dart';
import 'package:coralcartseller/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
              CustomButton(buttonName: 'Register', onPressed: registerHandler)
            ]),
          ),
        ));
  }

  void registerHandler() {
    if (_formKey.currentState!.validate()) {
      print(shopNameController.text);
      print(emailController.text);
      print(phoneController.text);
      print(passwordController.text);
      print(confirmPasswordController.text);
    }
  }
}
