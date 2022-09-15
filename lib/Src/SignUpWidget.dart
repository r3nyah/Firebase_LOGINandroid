import 'package:firebase_auth/firebase_auth.dart';
/*import 'package:firebase_auth_email/main.dart';
import 'package:firebase_auth_email/utils/utils.dart';*/
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase_season7/Src/Utils.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 250,),
            Text(
              'Flutter SignUp with Firebase',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 50,),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email)
              =>email!=null&&!EmailValidator.validate(email)
                ? 'Enter a validate email'
                : null,
            ),
            SizedBox(height: 4,),
            TextFormField(
              controller: passController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value)
              =>value!=null&&value.length<6
                ? 'Enter minimun 6 characters of password'
                : null,
            ),
            SizedBox(height: 20,),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(
                Icons.lock_open,
                size: 32,
              ),
              label: Text(
                'Sing-Up',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onPressed: signUp,
            ),
            SizedBox(height: 24,),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    text: 'Already have an account? ',
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignUp,
                          text: 'Log In',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.secondary,
                          )
                      )
                    ]
                )
            )
          ],
        ),
      ),
    );
  }
  Future signUp()async{
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
    }on FirebaseAuthException catch(e){
      print(e);

      Utils.showSnackBar(e.message);
    }
  }
}
