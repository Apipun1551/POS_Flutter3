import 'package:dartz/dartz.dart';
import 'package:fic23pos_flutter/core/constants/variables.dart';
import 'package:fic23pos_flutter/data/datasource/auth_local_datasource.dart';
import 'package:fic23pos_flutter/data/models/response/product_sales_report.dart';
import 'package:fic23pos_flutter/data/models/response/product_report_model.dart';
import 'package:fic23pos_flutter/presentation/tablet/setting/pages/report_tablet_page.dart';
import 'package:http/http.dart' as http;

class ReportRemoteDatasource {
  Future<Either<String, SummaryResponseModel>> getSummaryReport(
    String startDate,
    String endDate,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
        '${Variables.baseUrl}/api/reports/summary?start_date=$startDate&end_date=$endDate',
      ),
      headers: {'Authorization': 'Bearer ${authData?.token}'},
    );
    if (response.statusCode == 200) {
      return right(SummaryResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, ProductSalesResponseModel>> getProductSales(
    String startDate,
    String endDate,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
        '${Variables.baseUrl}/api/reports/product-sales?start_date=$startDate&end_date=$endDate',
      ),
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return right(ProductSalesResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, ProductReportResponseModel>> getProductReport(
    String startDate,
    String endDate,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
        '${Variables.baseUrl}/api/reports/product-report?start_date=$startDate&end_date=$endDate',
      ),
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return right(ProductReportResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
