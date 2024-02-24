import 'package:chat_app/shared/constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';
import '../shared/component/component.dart';
import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
 static String routeName =" RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
late String email;
late String password;
bool isLoading = false;

GlobalKey<FormState> formKey =  GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:isLoading,
      child: Scaffold(
        backgroundColor:AppColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    // const Spacer(flex: 1),
                    SizedBox(height: 70),
                    Image.asset("assets/images/scholar.png"),
                    const Text("Scholar Chat", style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold, color: Colors.white)),
                    // const Spacer(flex: 1),
                    SizedBox(height: 80),
                    const Row(
                      children: [
                        Text("Register", style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white ),),
                      ],
                    ),
                    const SizedBox(height: 15),
                    defaultFormField(hintText: "Email",color: Colors.white,
                        onchange: (data)
                        {
                          email= data;
                        }),
                    const SizedBox(height: 10),
                    defaultFormField(hintText: "password", color: Colors.white,
                        onchange: (data)
                       {
                         password= data;
                       }),
                    const SizedBox(height: 15),
                    defaultBottom(text: "Register",
                      onTap: () async {
                      if(formKey.currentState!.validate()){
                        isLoading = true;
                        setState(() {});
                        try{
                          await registerUser();
                          showSnackBar(context, "Success");
                        }on FirebaseAuthException catch(ex){
                          if(ex.code == "weak password"){
                            showSnackBar(context, "weak password");
                          }else if(ex.code == "email-already-in-use"){
                            showSnackBar(context, "email is already exist");
                          }
                        }
                        isLoading = false;
                        setState(() {});
                        Navigator.pushNamed(context, ChatPage.routeName, arguments: email);
                      }else {
                        showSnackBar(context, "Field is Error");
                      }
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account ! !", style: TextStyle(color: Colors.white)),
                         InkWell(
                             onTap: ()
                             {
                               Navigator.pop(context);
                             },
                             child: const Text("Register", style: TextStyle( color: Color(0xffC7EDE6)))),
                      ],
                    ),
                    // const Spacer(flex: 1),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> registerUser() async {
     UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword
      (email: email, password: password);
  }
}
