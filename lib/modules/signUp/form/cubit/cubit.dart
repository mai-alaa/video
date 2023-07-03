import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_call_app/modules/signUp/form/cubit/states.dart';

class SelectedRoleCubit extends Cubit<SelectRoleStates> {
  SelectedRoleCubit() : super(InitialSelectedRoleState());

  static SelectedRoleCubit get(context) => BlocProvider.of(context);
  String? role;

  void selectRole({
    String? role,
  }) {
    if (role != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc('uId')
          .update({'role': role}).then((value) {
        emit(SelectedRolSubmittedState(role));
      }).catchError((error) {
        emit(ErrorSelectedRoleState(error.toString()));
      });
    }
  }
}
