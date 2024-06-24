// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({
    required UserService userService,
  }) : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.googleLogin();

      if (user != null) {
        success();
      } else {
        _userService.googleLogout;
        setError('Error when logging in with Google');
      }
    } on AuthException catch (e) {
      _userService.googleLogout;
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('User or password invalid!');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      infoMessage = null;
      showLoadingAndResetState();
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Password reset sent to your email';
    } catch (e) {
      if (e is AuthException) {
        setError(e.message);
      } else {
        setError('Error when resetting the password!');
      }
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
