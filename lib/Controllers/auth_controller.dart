import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_phone/Models/user.dart';

import '../main.dart';

class AuthController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseAuthInstance = FirebaseAuth.instance;
  void onLeaveSignIn() {
    signInEmailController.clear();
    signInPasswordController.clear();
    loginFormKey.currentState?.reset();
    update();
  }

  void onLeavePasswordReset() {
    resetPasswordController.clear();
    resetPasswordFormKey.currentState?.reset();
    Get.back();
    Get.back();
    update();
    return;
  }

  void onLeaveRegister() {
    fullNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerFormKey.currentState?.reset();
    Get.back();
    Get.back();
    update();
    return;
  }

  bool showPasswordLogin = true;
  void showPasswordFunctionLogin() {
    showPasswordLogin = !showPasswordLogin;
    update();
  }

  bool showPasswordRegister = true;
  void showPasswordFunctionRegister() {
    showPasswordRegister = !showPasswordRegister;
    update();
  }

  bool isLoading = false;
  void toggleLoading(bool state) {
    isLoading = state;
    update();
  }

  bool signInError = false;
  bool passwordResetError = false;
  bool registerError = false;
  String errorText = '';
  void exitDialogue() {
    signInError = false;
    registerError = false;
    passwordResetError = false;
    errorText = '';
    update();
  }

  String handleError(String exception) {
    switch (exception) {
      case 'invalid-credential':
        return 'email or password entered do not correspond to any account. please check your information.'
            .tr;
      case 'email-already-in-use':
        return 'the email address you entered is already in use by a different account.'
            .tr;
      case 'network-request-failed':
        return 'network error. please try again later.'.tr;
      case 'too-many-requests':
        return 'too many requests. please wait before trying again.'.tr;
      case 'user-not-found':
        return 'no account is associated with the entered email address.'.tr;
      default:
        return exception;
    }
  }

  void register() async {
    try {
      toggleLoading(true);
      UserCredential userCredential =
          await firebaseAuthInstance.createUserWithEmailAndPassword(
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text,
      );
      await firestoreInstance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(
            MyUser(
              userId: userCredential.user!.uid,
              email: registerEmailController.text.trim(),
              fullName: fullNameController.text,
            ).toJson(),
          );
      registerError = false;
      toggleLoading(false);
      loginCheck!.setString('loggedIn', 'true');
      Get.offAllNamed('/home');
    } on FirebaseException catch (e) {
      registerError = true;
      errorText = handleError(e.code);
      toggleLoading(false);
    }
  }

  void signIn() async {
    try {
      toggleLoading(true);
      await firebaseAuthInstance.signInWithEmailAndPassword(
        email: signInEmailController.text.trim(),
        password: signInPasswordController.text,
      );
      signInError = false;
      toggleLoading(false);
      loginCheck!.setString('loggedIn', 'true');
      Get.offAllNamed('/home');
    } on FirebaseException catch (e) {
      signInError = true;
      errorText = handleError(e.code);
      toggleLoading(false);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void resetPassword() async {
    try {
      toggleLoading(true);
      await firebaseAuthInstance.sendPasswordResetEmail(
        email: resetPasswordController.text.trim(),
      );
      passwordResetError = false;
      toggleLoading(false);
    } on FirebaseAuthException catch (e) {
      passwordResetError = true;
      errorText = handleError(e.code);
      toggleLoading(false);
    }
  }
}
