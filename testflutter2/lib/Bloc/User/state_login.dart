abstract class LoginState {}

class LoginSucess extends LoginState {
  String status = 'success';
}

class LoginFail extends LoginState {}

class Logout extends LoginState {}

class LoginLoading extends LoginState {}
