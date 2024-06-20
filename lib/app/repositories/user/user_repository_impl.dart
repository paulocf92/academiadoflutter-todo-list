// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);

      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'Email already in use, choose another one.');
        } else {
          throw AuthException(
              message: 'You used Google to register, use it again to login.');
        }
      } else {
        throw AuthException(
            message: e.message ?? 'Error when registering user!');
      }
    }
  }
}
