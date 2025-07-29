import 'auth_api.dart';

class AuthService {
  static String? token;

  Future<bool> login(String email, String password) async {
    try {
      final responseData = await AuthAPI.login(email, password);
       token = responseData['data']['token'];
      // save token
      print('Login success. Token: $token');

      print('goooood');
      return true;
    } catch (e) {
      print('Login failed: $e');
      return false;
    }
  }

// logout
  void logout() {
    token = null;
    print('User logged out');
  }
// register
  Future<bool> register(String name, String email, String password, String passwordConfirmation) async {
    try {
      final responseData = await AuthAPI.register(name, email, password, passwordConfirmation);
      token = responseData['data']['token'];
      print('Register success. Token: $token');
      return true;
    } catch (e) {
      print('Register failed: $e');
      return false;
    }
  }
  //forget pass
  Future<bool> forgetPassword(String email) async {
    try {
      final responseData = await AuthAPI.forgetPassword(email);
      print('Reset email sent: ${responseData['message']}');
      return true;
    } catch (e) {
      print('Forget password failed: $e');
      return false;
    }
  }
//   code
  Future<bool> verifyForgetPasswordCode(String email, String verifyCode) async {
    try {
      final responseData = await AuthAPI.checkForgetPassword(email, verifyCode);
      print('Verification success: ${responseData['message']}');
      return true;
    } catch (e) {
      print('Verification failed: $e');
      return false;
    }
  }
// reset pass
  Future<bool> resetPassword(String email, String verifyCode, String newPassword, String confirmPassword) async {
    try {
      final response = await AuthAPI.resetPassword(email, verifyCode, newPassword, confirmPassword);
      return true;
    } catch (e) {
      print('Reset password failed: $e');
      return false;
    }
  }



}
