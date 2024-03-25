import 'package:coralcartseller/screen/home_screen.dart';
import 'package:coralcartseller/screen/register_screen.dart';
import 'package:coralcartseller/screen/root_screen.dart';
import 'package:coralcartseller/services/firebase_auth_services.dart';
import 'package:coralcartseller/utils/helper.dart';
import 'package:coralcartseller/widgets/custom_button.dart';
import 'package:coralcartseller/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading=false;

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
          SizedBox(height: 30,),
           _loading ? Center(child:CircularProgressIndicator(color: Colors.teal,),):
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomButton(buttonName: 'Login',onPressed: loginHandler,),
          ),
          
          
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dont have account",
                style: TextStyle(color: Color.fromARGB(255, 226, 24, 24)),
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
void loginHandler() async {
    if (_formKey.currentState!.validate()) {
       FirebaseAuthService firebaseAuthService = FirebaseAuthService();
      try{
        setState(() {
          _loading= true;
        });
        
        await firebaseAuthService.login(
          
          password: passwordController.text,
        
          email: emailController.text,
        );
        
        _loading = false;

        MotionToast.success(
          title: Text("Success"),
          description: Text("Login Successful"),
        ).show(context);

        if(context.mounted){
          Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => RootScreen(),
          ),
          (route) => false);
        }

      }
      catch(e){
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