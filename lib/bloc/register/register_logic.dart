import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testslogreg/bloc/register/register_state.dart';

class RegisterLogic extends Cubit<RegisterState> {
  RegisterLogic() : super(RegisterInitial());

  Future<void> registerUser(
      {required String Name,
      required String Email,
      required String Password,
      required String Phone}) async {
    emit(RegisterLoading());

    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: Email, password: Password);
      emit(RegisterSucces());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak password') {
        emit(RegisterFailure(errorMessage: 'weak password'));
      } else if (ex.code == 'email already in use') {
        emit(RegisterFailure(errorMessage: 'email already in use'));
      }
    } catch (e) {
      emit(
          RegisterFailure(errorMessage: 'there was an error please try again'));
    }
  }
}
