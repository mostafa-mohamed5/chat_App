
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
 RegisterPage({super.key,});
 static const String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
 String? email;

 String? password;

 GlobalKey<FormState> formKey =GlobalKey();

 bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KprimaryColor,
       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 8),
         child: Form(
          key:formKey ,
           child: ListView(
            children: [
              SizedBox(
              height: 75,
             ),
             Image.asset(KLogo,
             height: 100,
             ),
             Center(
               child: Text('Scolar chat',
               style: TextStyle(
                fontSize:32,
                color: Colors.white,
                fontFamily:  'pacifico'
               ),
               ),
             ),
             SizedBox(
              height: 75,
             ),
             
             Row(
               children: [
                 Text('REGISTER',
                 style: TextStyle(
                  fontSize: 24,
                  color: Colors.white
                 ),
                 ),
               ],
             ),
            const SizedBox(
              height: 20,
             ),
             CustomFormTextField(
              onChanged: (data) {
                email=data;
              },
              hintText: 'Email',
              isEmail: true,
             ),
             const SizedBox(
              height: 10,
             ),
             CustomFormTextField(
              onChanged: (data) {
                password=data;
              },
              hintText: 'Password',
              isPassword: true,
             ),
             const SizedBox(
              height: 20,
             ),
             CustomButton(
              onTap: () async{
              
             if (formKey.currentState!.validate()) {
              isLoading=true;
              setState(() {
                
              });
        try {
        await registerUser();
         Navigator.pushNamed(context, ChatPage.id);
             } on FirebaseAuthException catch (ex) {
        if (ex.code == 'weak-password') {
             showSnackBar(context,'weak-password');
        } else if (ex.code == 'email-already-in-use') {
        showSnackBar(context, 'email-already-in-use');
             
        }
             }
        catch(ex)
        {
      showSnackBar(context, 'there was an erorr');
        }
        isLoading =false;
        setState(() {
          
        });
             
      } else 
      {
        
      }
                 
              },
              text: 'REGISTER',
             ),
             const SizedBox(
              
              height: 10,
             ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('already have an account ?',
                style: TextStyle(
                  color: Colors.white
                ),
                ),
                GestureDetector(
                  onTap: () {
                     Navigator.pop(context,);
                  },
                  child: Text('  Login',
                  style: TextStyle(
                    color: Color(0xffC7EDE6)
                  ),),
                )
              ],
             ),
             
           
            ],
           ),
         ),
       ),
      ),
    );
  }

  
  Future<void> registerUser() async {
     UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!);
  }
}