// import 'package:dartz/dartz.dart';

// import 'package:docs_flutter/app/data/models/custom_error/custom_error.dart';
// import 'package:docs_flutter/app/data/models/token/token_response_model.dart';
// import 'package:docs_flutter/app/data/providers/auth/auth_provider.dart';

// class AuthRepository {
//   final AuthProvider _provider = AuthProvider();
//   ResponseEither<LoginResponseModel> login() async {
//     try {
//       final result = await _provider.login();
//       return Right(result);
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }

//   ResponseEither<LoginResponseModel> loginWithIdToken(
//       {required String idToken,}) async {
//     try {
//       final result = await _provider.loginWithIdToken(idToken: idToken);
//       return Right(result);
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }

//   ResponseEither<TokenResponseModel> refreshToken() async {
//     try {
//       final result = await _provider.refreshToken();
//       return Right(result);
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }
// }
