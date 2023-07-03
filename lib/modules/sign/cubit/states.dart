abstract class AppLoginState {}

class AppLoginInitialState extends AppLoginState {}

class AppLoadingState extends AppLoginState {}

class AppLoginSuccessState extends AppLoginState {
  final String? uId;
  AppLoginSuccessState(this.uId);
}

class AppLoginErrorState extends AppLoginState {
  late String error;
  AppLoginErrorState(this.error);
}
