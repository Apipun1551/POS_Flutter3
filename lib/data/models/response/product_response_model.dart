import 'dart:convert';
import 'package:fic23pos_flutter/data/models/response/category_response_model.dart';

class ProductResponseModel {
  final String? message;
  final List<Product>? data;

  ProductResponseModel({this.message, this.data});

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJsonString() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Product {
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final int? categoryId;
  final String? image;
  final int? stock;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;
  // final String? unit;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.image,
    this.stock,
    this.createdAt,
    this.updatedAt,
    this.category,
    // this.unit,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"] is String
            ? double.tryParse(json["price"])
            : (json["price"] is int
                ? (json["price"] as int).toDouble()
                : json["price"]?.toDouble()),
        categoryId: json["category_id"],
        image: json["image"],
        stock: json["stock"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse(json["updated_at"]),
        category:
            json["category"] == null ? null : Category.fromMap(json["category"]),
        // unit: json['unit'], // mapping dari API/DB
      );

  // untuk update product: hanya kirim field yang valid
  Map<String, dynamic> toUpdateMap() => {
        if (name != null) 'name': name,
        if (price != null) 'price': price,
        if (stock != null) 'stock': stock,
        // if (unit != null) 'unit': unit,
      };

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "category_id": categoryId,
        "image": image,
        "stock": stock,
        // "unit": unit,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toMap(),
      };
  }

  extension ProductAddMap on Product {
    Map<String, dynamic> toAddMap() {
      return {
        'name': name,
        'price': price,
        'stock': stock,
        // 'unit': unit,
      };
    }
  }