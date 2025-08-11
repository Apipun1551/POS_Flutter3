import 'package:dartz/dartz.dart';
import 'package:fic23pos_flutter/core/constants/variables.dart';
import 'package:fic23pos_flutter/data/datasource/auth_local_datasource.dart';
import 'package:fic23pos_flutter/data/models/request/order_request_model.dart';
import 'package:fic23pos_flutter/data/models/response/history_response_model.dart';
import 'package:fic23pos_flutter/data/models/response/order_response_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
    OrderRequestModel data,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return right(OrderResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, HistoryResponseModel>> getOrders() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return right(HistoryResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
