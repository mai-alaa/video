abstract class SelectRoleStates {}

class InitialSelectedRoleState extends SelectRoleStates {}

class LoadingSelectedRoleState extends SelectRoleStates {}

class SelectedRolSubmittedState extends SelectRoleStates {
  final String? role;
  SelectedRolSubmittedState(this.role);
}

class ErrorSelectedRoleState extends SelectRoleStates {
  late String error;
  ErrorSelectedRoleState(this.error);
}
