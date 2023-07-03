import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_call_app/models/userModel.dart';
import 'package:video_call_app/modules/signUp/cubit/states.dart';

import 'package:video_call_app/shared/cubit/states.dart';

class AppRegisterCubit extends Cubit<AppRegisterState> {
  AppRegisterCubit() : super(AppRegisterInitialState());

  static AppRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
    String? role,
  }) {
    emit(AppRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
          email: email,
          uId: value.user!.uid,
          phone: phone,
          name: name,
          role: role);

      emit(AppRegisterSuccessState());
    }).catchError((error) {
      emit(AppRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String uId,
    required String phone,
    required String name,
    String? role,
  }) {
    UserModel model =
        UserModel(name: name, email: email, phone: phone, uId: uId, role: role);

    FirebaseFirestore.instance
        .collection('users')
        .doc('uId')
        .set(model.toMap())
        .then((value) {
      emit(AppCreateUserSuccessState(uId));
    }).catchError((error) {
      emit(AppCreateUserErrorState(error.toString()));
    });
  }
}
