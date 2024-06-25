// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredentials.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Error when loggin in.');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'invalid-credential') {
        throw AuthException(message: 'Invalid email or password.');
      }
      throw AuthException(message: e.message ?? 'Error when loggin in.');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      print('LoginMethods');
      print(loginMethods);

      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message: 'User registered with Google, password can\'t be reset!');
      } else {
        throw AuthException(message: 'Email not registered or not found!');
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: 'Error when resetting password.');
    }
  }

  @override
  Future<User?> googleLogin() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginMethods.contains('password')) {
          throw AuthException(
              message:
                  'You used email for registering; if you forgot your password, click on Forgot Password link.');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          final userCredential =
              await _firebaseAuth.signInWithCredential(firebaseCredential);

          return userCredential.user;
        }
      } else {
        throw AuthException(
            message: 'Error when attempting to login in with Google!');
      }
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);

      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
            message:
                'Invalid login, you used other providers to create your account!');
      } else {
        throw AuthException(message: 'Error when logging in');
      }
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      await user.updateDisplayName(name);
      // The following line will trigger AuthProvider's listener idTokenChanges
      user.reload();
    }
  }
}
