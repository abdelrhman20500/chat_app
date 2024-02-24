import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/cubit/login-cubit.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.routeName : (_)=>LoginPage(),
          RegisterPage.routeName :(_) =>RegisterPage(),
          ChatPage.routeName : (_)=> ChatPage(),
        },
        initialRoute:LoginPage.routeName,
      ),
    );
  }
}

