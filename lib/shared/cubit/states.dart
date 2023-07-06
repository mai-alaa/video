abstract class AppState {}

class AppInitialState extends AppState {}

class AppErrorState extends AppState {
  late String error;
  AppErrorState(this.error);
}
