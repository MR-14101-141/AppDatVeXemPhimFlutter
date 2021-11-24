import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testflutter2/Bloc/User/state_login.dart';
import 'package:testflutter2/repository/login_repository.dart';
import 'event_login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _loginRepository = LoginRepository();

  LoginBloc() : super(LoginLoading()) {
    on<Login>(_onLogin);
  }

  void _onLogin(Login event, Emitter<LoginState> emit) async {
    String status = await _loginRepository.login(
        emailKH: event.emailKH, passwordKH: event.passwordKH);
    if (status == 'success') {
      emit(LoginSucess());
    } else {
      emit(LoginFail());
    }
  }
}
