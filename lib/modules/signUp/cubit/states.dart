abstract class AppRegisterState {}

class AppRegisterInitialState extends AppRegisterState {}

class AppRegisterLoadingState extends AppRegisterState {}

class AppRegisterSuccessState extends AppRegisterState {}

class AppRegisterErrorState extends AppRegisterState {
  late String error;
  AppRegisterErrorState(this.error);
}

class AppCreateUserSuccessState extends AppRegisterState {
  final String? uId;

  AppCreateUserSuccessState(this.uId);
}

class AppCreateUserErrorState extends AppRegisterState {
  late String error;
  AppCreateUserErrorState(this.error);
}
