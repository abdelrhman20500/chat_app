import 'package:chat_app/screens/cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() :super(LoginInitial());

  Future<void> signInUser({required String email, required String password}) async {
    emit(LoginInitial());
    try
    {
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccess());
    }on FirebaseAuthException catch(ex){
        if(ex.code == "User Not Found"){
          emit(LoginFailure(errMessage: "User Not Found"));
        }else if(ex.code == "Wrong Password"){
          emit(LoginFailure(errMessage: "Wrong password"));
        }
      }on Exception catch(e)
    {
      emit(LoginFailure(errMessage: "Something went Wrong"));
    }
  }
}