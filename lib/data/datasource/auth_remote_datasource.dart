import 'package:fic23pos_flutter/core/constants/variables.dart';
import 'package:fic23pos_flutter/data/datasource/auth_local_datasource.dart';
import 'package:fic23pos_flutter/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final authResponse = AuthResponseModel.fromJson(response.body);
      return Right(authResponse);
    } else {
      return Left('Login failed: ${response.reasonPhrase}');
    }
  }

  Future<Either<String, AuthResponseModel>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: {'Authorization': 'Bearer ${authData?.token}'},
    );
    if (response.statusCode == 200) {
      await AuthLocalDatasource().clearAuthData();
      return Right(AuthResponseModel(message: 'Logout successful'));
    } else {
      return Left('Logout failed: ${response.reasonPhrase}');
    }
  }
}
