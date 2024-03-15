import 'package:coralcartseller/screen/home_screen.dart';
import 'package:coralcartseller/screen/register_screen.dart';
import 'package:coralcartseller/utils/helper.dart';
import 'package:coralcartseller/widgets/custom_button.dart';
import 'package:coralcartseller/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool passwordVisibility = true;
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(),
          CustomTextField(
            controller: emailController,
            hintText: 'enter your email',
            label: 'Email',
            validate: (value) {
              return validateMail(value!);
              
            },
            ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: TextFormField(
              controller: passwordController,
              validator: (value) {
                return validatePassword(value!);
              },
              obscureText: passwordVisibility,
              decoration: InputDecoration(
                label: const Text('Password'),
                hintText: 'Enter your password',
                suffixIcon:
                    IconButton(onPressed: () {
                      setState(() {
                        passwordVisibility= !passwordVisibility;
                      });
                    }, icon: Icon(
                      passwordVisibility ? Icons.visibility :Icons.visibility_off
                      ),
                    ),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          CustomButton(buttonName: 'Login',onPressed: loginHandler,),
          
          
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dont have account",
                style: TextStyle(color: const Color.fromARGB(255, 194, 69, 69)),
              ),
              TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                  },
                  child: const Text('Register')),
            ],
          ),
        ]),
      ),
    );
  }
void loginHandler(){
  if(_formKey.currentState!.validate()){
    print(emailController.text);
    print(passwordController.text);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false);





  }
}



}



