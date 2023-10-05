// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/foundation.dart';
// import 'package:docs_flutter/app/data/models/index.dart';
// import 'package:docs_flutter/app/index.dart';

// class AuthProvider extends BaseService {
//   AuthProvider();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<LoginResponseModel> login() async {
//     try {
//       return restClient
//           .post(
//         url: APIPath.LOGIN_ANNONYMOUSLY,
//       )
//           .then((value) async {
//         final response =
//             LoginResponseModel.fromJson(value as Map<String, dynamic>);
//         await response.saveData();
//         await onTokenChange();
//         return response;
//       });
//     } catch (e) {
//       await FirebaseCrashlytics.instance.log(e.toString());
//       rethrow;
//     }
//   }

//   Future<LoginResponseModel> loginWithIdToken({required String idToken}) async {
//     try {
//       return restClient.post(
//         url: APIPath.LOGIN,
//         params: {'idToken': idToken},
//       ).then((value) async {
//         final response =
//             LoginResponseModel.fromJson(value as Map<String, dynamic>);
//         await response.saveData();
//         await onTokenChange();
//         return response;
//       });
//     } catch (e) {
//       await FirebaseCrashlytics.instance.log(e.toString());
//       rethrow;
//     }
//   }

//   Future<TokenResponseModel> refreshToken() async {
//     try {
//       return restClient
//           .post(
//         withAuthBearerHeader: false,
//         url: APIPath.REFRESH_TOKEN +
//             StorageUtil.getString(LocalStorageKey.REFRESH_TOKEN),
//       )
//           .then((value) async {
//         final tokenData =
//             TokenResponseModel.fromJson(value as Map<String, dynamic>);
//         await tokenData.saveToken();
//         await onTokenChange();
//         return tokenData;
//       }).onError(
//         (e, s) {
//           throw CustomError().toString();
//         },
//       );
//     } catch (e) {
//       await FirebaseCrashlytics.instance.log(e.toString());
//       rethrow;
//     }
//   }

//   Future<void> requestCodeForVerify({
//     required String phoneNumber,
//     required String countryCode,
//     required void Function(FirebaseAuthException e) firebaseAuthException,
//     required void Function(PhoneAuthCredential p) phoneAuthCredential,
//     required void Function(String code) codeAutoRetrievalTimeout,
//     required void Function(String verificationId, int? resendToken) codeSent,
//     int? resendToken,
//   }) async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: '$countryCode $phoneNumber',
//         timeout: const Duration(seconds: 40),
//         verificationCompleted: phoneAuthCredential,
//         verificationFailed: firebaseAuthException,
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//         forceResendingToken: resendToken,
//       );
//     } catch (e) {
//       await FirebaseCrashlytics.instance.log(e.toString());
//       rethrow;
//     }
//   }

//   Future<void> signOut() async {
//     await _auth.signOut();
//   }

//   // firebase phone verify
//   Future<UserCredential?> verifyCode({
//     required String verificationId,
//     required String smsCode,
//   }) async {
//     try {
//       final credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: smsCode,
//       );
//       final authCredential = await _auth.signInWithCredential(credential);
//       if (authCredential.user != null) {
//         // final uid = authCredential.user!.uid;
//         return authCredential;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       if (!kDebugMode) await FirebaseCrashlytics.instance.log(e.toString());
//       rethrow;
//     }
//   }
// }
