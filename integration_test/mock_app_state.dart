import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_big5workout/interface/app_state.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

class MockApplicationState extends ChangeNotifier implements ApplicationState {
  MockApplicationState() {
    init();
  }

  bool _loggedIn = false;

  @override
  bool get loggedIn => _loggedIn;

  @override
  Future<void> init() async {
    final googleSignIn = MockGoogleSignIn();
    final signinAccount = await googleSignIn.signIn();
    final googleAuth = await signinAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Sign in.
    final userConfig = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bobIsCool@somedomain.com',
      displayName: 'Bob Cool',
    );
    final auth = MockFirebaseAuth(mockUser: userConfig);
    await auth.signInWithCredential(credential);
    // final user = result.user!;

    auth.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}
