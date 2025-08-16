import 'package:fic23pos_flutter/data/models/response/product_response_model.dart';
import 'package:fic23pos_flutter/presentation/home/models/order_item.dart';

class StockValidator {
  /// Mengecek apakah stok produk cukup untuk quantity yang diminta
  static StockValidationResult validateStock({
    required Product product,
    required int requestedQuantity,
    List<OrderItem>? existingOrders,
  }) {
    if (product.stock == null) {
      return StockValidationResult(
        isValid: false,
        message: 'Stok produk tidak tersedia',
        availableStock: 0,
        requestedQuantity: requestedQuantity,
      );
    }

    // Hitung total quantity yang sudah ada di order
    int existingQuantity = 0;
    if (existingOrders != null) {
      final existingItem = existingOrders.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => OrderItem(product: product, quantity: 0),
      );
      existingQuantity = existingItem.quantity;
    }

    final totalRequested = requestedQuantity + existingQuantity;
    final availableStock = product.stock ?? 0;

    if (availableStock <= 0) {
      return StockValidationResult(
        isValid: false,
        message: 'Maaf, produk "${product.name}" sedang habis',
        availableStock: availableStock,
        requestedQuantity: requestedQuantity,
      );
    }

    if (totalRequested > availableStock) {
      final remainingStock = availableStock - existingQuantity;
      if (remainingStock <= 0) {
        return StockValidationResult(
          isValid: false,
          message: 'Produk "${product.name}" sudah mencapai batas stok yang tersedia',
          availableStock: availableStock,
          requestedQuantity: requestedQuantity,
        );
      }
      
      return StockValidationResult(
        isValid: false,
        message: 'Stok ${product.name} tidak cukup. '
            'Tersedia: $availableStock, '
            'Diminta: $totalRequested',
        availableStock: availableStock,
        requestedQuantity: requestedQuantity,
        suggestedQuantity: remainingStock > 0 ? remainingStock : null,
      );
    }

    return StockValidationResult(
      isValid: true,
      message: 'Stok tersedia',
      availableStock: availableStock,
      requestedQuantity: requestedQuantity,
    );
  }

  /// Mengecek stok untuk multiple produk sekaligus
  static List<StockValidationResult> validateMultipleStocks({
    required List<OrderItem> orderItems,
  }) {
    final results = <StockValidationResult>[];
    
    for (final item in orderItems) {
      final result = validateStock(
        product: item.product,
        requestedQuantity: item.quantity,
      );
      results.add(result);
    }
    
    return results;
  }
}

class StockValidationResult {
  final bool isValid;
  final String message;
  final int availableStock;
  final int requestedQuantity;
  final int? suggestedQuantity;

  StockValidationResult({
    required this.isValid,
    required this.message,
    required this.availableStock,
    required this.requestedQuantity,
    this.suggestedQuantity,
  });

  bool get hasSuggestion => suggestedQuantity != null;
}
