import 'package:flutter/material.dart';
import 'package:fic23pos_flutter/core/utils/stock_validator.dart';
import 'package:fic23pos_flutter/core/components/stock_warning_dialog.dart';
import 'package:fic23pos_flutter/data/models/response/product_response_model.dart';
import 'package:fic23pos_flutter/presentation/home/models/order_item.dart';

class OrderHelpers {
  /// Mengecek stok sebelum menambahkan produk ke order
  static bool validateAndShowStockWarning({
    required BuildContext context,
    required Product product,
    required int requestedQuantity,
    List<OrderItem>? existingOrders,
    Function(int)? onAcceptSuggestion,
  }) {
    final result = StockValidator.validateStock(
      product: product,
      requestedQuantity: requestedQuantity,
      existingOrders: existingOrders,
    );

    if (!result.isValid) {
      if (product.stock == null || product.stock == 0) {
        StockWarningDialog.showOutOfStock(
          context: context,
          productName: product.name ?? 'Produk',
        );
      } else {
        StockWarningDialog.show(
          context: context,
          result: result,
          onAcceptSuggestion: result.hasSuggestion && onAcceptSuggestion != null
              ? () {
                  Navigator.pop(context);
                  onAcceptSuggestion(result.suggestedQuantity!);
                }
              : null,
          onCancel: () => Navigator.pop(context),
        );
      }
      return false;
    }
    return true;
  }

  /// Membuat pesan ringkas untuk stok tidak cukup
  static String getStockWarningMessage({
    required Product product,
    required int requestedQuantity,
  }) {
    final result = StockValidator.validateStock(
      product: product,
      requestedQuantity: requestedQuantity,
    );

    if (!result.isValid) {
      return result.message;
    }
    return '';
  }

  /// Mengecek apakah produk masih tersedia
  static bool isProductAvailable(Product product) {
    return (product.stock ?? 0) > 0;
  }

  /// Mendapatkan jumlah maksimum yang bisa dipesan
  static int getMaxOrderQuantity(Product product) {
    return product.stock ?? 0;
  }
}
