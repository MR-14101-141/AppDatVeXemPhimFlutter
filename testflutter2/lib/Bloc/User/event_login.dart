abstract class LoginEvent {}

class Login extends LoginEvent {
  final String emailKH;
  final String passwordKH;

  Login(this.emailKH, this.passwordKH);
}

class Logout extends LoginEvent {}
