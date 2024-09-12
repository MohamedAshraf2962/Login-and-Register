import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testslogreg/bloc/login/login_state.dart';

class LoginLogic extends Cubit<LoginState> {
  LoginLogic() : super(LoginInitial());


  Future<void> loginUser(
      {required String Email, required String Password}) async {
    emit(LoginLoading());

    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email, password: Password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(
          errorMessage: 'User Not Found'
        ));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(
          errorMessage: 'Wrong Password'
        ));
      }
    } catch (e) {
      emit(LoginFailure(
        errorMessage: 'Something Went Wrong'
      ));
    }
  }
}