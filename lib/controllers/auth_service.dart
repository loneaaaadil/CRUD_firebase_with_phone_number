import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String verifyId = '';

  static Future sendOtp({
    required String phone,
    required Function errorStep,
    required Function nextStep,
  }) async {
    print('asdfasdfa $phone');
    await _firebaseAuth
        .verifyPhoneNumber(
          timeout: const Duration(seconds: 30),
          phoneNumber: "+91$phone",
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            return;
          },
          verificationFailed: (error) async {
            errorStep();

            return;
          },
          codeSent: ((verificationId, forceResendingToken) async {
            verifyId = verificationId;

            nextStep();
            return;
          }),
          codeAutoRetrievalTimeout: (verficationId) async {
            return;
          },
        )
        .onError(
          (error, stackTrace) => errorStep(),
        );
  }

  //verify otp
  static Future loginWithOtp(String otp) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
    try {
      final user = await _firebaseAuth.signInWithCredential(cred);
      if (user.user != null) {
        return 'Sucess';
      } else {
        return "Error in Otp";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // logout the user

  static Future logOut() async {
    await _firebaseAuth.signOut();
  }

  // check whether the user is  login or logout

  static Future<bool> isLogedIn() async {
    var user = _firebaseAuth.currentUser;
    return user != null;
  }
}
