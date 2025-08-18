import 'dart:convert';

int safeParseInt(dynamic value) {
  try {
    if (value == null) return 0;
    return int.parse(value.toString());
  } catch (e) {
    return 0;
  }
}

class ProductReportResponseModel {
  final String status;
  final List<ProductReport> data;

  ProductReportResponseModel({required this.status, required this.data});

  factory ProductReportResponseModel.fromMap(Map<String, dynamic> map) {
    return ProductReportResponseModel(
      status: map['status'] as String,
      data: List<ProductReport>.from(
        map["data"].map((x) => ProductReport.fromMap(x)),
      ),
    );
  }

  factory ProductReportResponseModel.fromJson(String source) =>
      ProductReportResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

class ProductReport {
  final int productId;
  final String productName;
  final int productPrice;
  final String categoryName;
  final int totalQuantity;
  final int totalRevenue;

  ProductReport({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.categoryName,
    required this.totalQuantity,
    required this.totalRevenue,
  });

  factory ProductReport.fromMap(Map<String, dynamic> map) {
    return ProductReport(
      productId: map['product_id'] ?? 0,
      productName: map['product_name'] ?? '',
      productPrice: (map['product_price'] != null)
          ? (double.parse(map['product_price'].toString())).toInt()
          : 0,
      categoryName: map['category_name'] ?? '',
      totalQuantity: (map['total_quantity'] != null)
          ? (double.parse(map['total_quantity'].toString())).toInt()
          : 0,
      totalRevenue: (map['total_revenue'] != null)
          ? (double.parse(map['total_revenue'].toString())).toInt()
          : 0,
    );
  }
}
