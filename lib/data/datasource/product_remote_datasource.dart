import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fic23pos_flutter/core/constants/variables.dart';
import 'package:fic23pos_flutter/data/datasource/auth_local_datasource.dart';
import 'package:fic23pos_flutter/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/products'),
      headers: {'Authorization': 'Bearer ${authData?.token}'},
    );

    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, String>> addProduct(Map<String, dynamic> product) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/products'),
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(product),
    );

    if (response.statusCode == 201) {
      return right('Produk berhasil ditambahkan');
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, String>> updateProduct(int id, Map<String, dynamic> product) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.put(
      Uri.parse('${Variables.baseUrl}/api/products/$id'),
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(product),
    );

    if (response.statusCode == 200) {
      return right('Produk berhasil diupdate');
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, String>> deleteProduct(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.delete(
      Uri.parse('${Variables.baseUrl}/api/products/$id'),
      headers: {'Authorization': 'Bearer ${authData?.token}'},
    );

    if (response.statusCode == 200) {
      return right('Produk berhasil dihapus');
    } else {
      return left(response.body);
    }
  }
}
