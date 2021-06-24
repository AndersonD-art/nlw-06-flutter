import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

class LoginController {
  final authController = AuthController();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      final response = await _googleSignIn.signIn();
      final user = UserModel(
        name: response!.displayName!,
        photoURL: response.photoUrl!,
      );
      authController.setuser(context, user);
    } catch (error) {
      authController.setuser(context, null);
    }
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();
}
