import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get getCurrentUser => _firebaseAuth.currentUser;

  String? get getCurrentUserId => _firebaseAuth.currentUser?.uid;

  Stream<User?> get getAuthStateChange => _firebaseAuth.authStateChanges();

  String? get getUserId => null;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  Future<void> repairPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
