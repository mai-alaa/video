import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_call_app/modules/sign/cubit/states.dart';

import '../../signUp/cubit/states.dart';

class AppLoginCubit extends Cubit<AppLoginState> {
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);
  void userLogin({required String email, required String password}) {
    emit(AppLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(AppLoginSuccessState(value.user?.uid));
    }).catchError((error) {
      emit(AppLoginErrorState(error.toString()));
    });
  }

  static void onCreateButtonPressed(BuildContext context) {}
}
