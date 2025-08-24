import 'package:fic23pos_flutter/core/extensions/int_ext.dart';

//import 'product_category.dart';

class ProductModel {
  final String image;
  final String name;
  //final ProductCategory category;
  final int price;
  final int stock;
  // Tambahan satuan untuk UI (tidak ada di database)
  // String? unit;

  ProductModel({
    required this.image,
    required this.name,
    //required this.category,
    required this.price,
    required this.stock,
    // this.unit,
  });

  String get priceFormat => price.currencyFormatRp;
}
