import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    final authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return authResult;
    // UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    // return userCredential;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final authResult = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authResult;
  }

  Future<User> getUser() async => await auth.currentUser;
}
