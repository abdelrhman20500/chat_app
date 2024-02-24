import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/cubit/login-cubit.dart';
import 'package:chat_app/screens/cubit/login_states.dart';
import 'package:chat_app/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snack_bar.dart';
import '../shared/component/component.dart';
import '../shared/constant/constant.dart';

class LoginPage extends StatelessWidget {

  static String routeName ="LoginPage";

  String? email, password;
  bool isLoading = false;
  GlobalKey<FormState> formKey =  GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state)
      {
        if(state is LoginInitial)
        {
          isLoading =true;
        }else if(state is LoginSuccess)
        {
          Navigator.pushNamed(context, ChatPage.routeName);
          isLoading =false;
        }else if(state is LoginFailure)
          {
            showSnackBar(context,state.errMessage );
            isLoading =false;
          }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor:AppColors.primaryColor,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 70),
                    Image.asset("assets/images/scholar.png"),
                    const Text("Scholar Chat", style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold, color: Colors.white)),
                    // const Spacer(flex: 1),
                    SizedBox(height: 80),
                    const Row(
                      children: [
                        Text("LOGIN", style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white ),),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 15),
                    defaultFormField(hintText: "Email",color: Colors.white,
                        onchange: (data)
                        {
                          email= data;
                        }),
                    const SizedBox(height: 10),
                    defaultFormField(hintText: "password", color: Colors.white,
                        obscureText: true,
                        onchange: (data)
                        {
                          password= data;
                        }),
                    const SizedBox(height: 15),
                    defaultBottom(text: "LOGIN",
                      onTap: () async {
                        if(formKey.currentState!.validate()){
                          isLoading = true;
                          BlocProvider.of<LoginCubit>(context).signInUser(
                              email: email!, password: password!);
                          // try{
                          //   await signInUser();
                          //   showSnackBar(context, "Success");
                          // }on FirebaseAuthException catch(ex){
                          //   if(ex.code == "User Not Found"){
                          //     showSnackBar(context, "User Not Found");
                          //   }else if(ex.code == "Wrong Password"){
                          //     showSnackBar(context, "Wrong Password");
                          //   }
                          // }
                          // isLoading = false;
                          // Navigator.pushNamed(context, ChatPage.routeName, arguments: email);
                        }else {
                          showSnackBar(context, "Field is Error");
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don\'t have an account ! !", style: TextStyle(color: Colors.white)),
                        InkWell(
                            onTap: ()
                            {
                              Navigator.pushNamed(context, RegisterPage.routeName);
                            },
                            child: Text("Register", style: TextStyle( color: Color(0xffC7EDE6)))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
