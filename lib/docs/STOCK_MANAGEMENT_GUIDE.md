# Panduan Manajemen Stok dan Pesan Error

## Overview
Dokumen ini menjelaskan cara mengimplementasikan pesan peringatan stok dalam aplikasi POS.

## Komponen yang Tersedia

### 1. StockValidator
Utilitas untuk mengecek ketersediaan stok produk.

```dart
import 'package:fic23pos_flutter/core/utils/stock_validator.dart';

// Contoh penggunaan
final result = StockValidator.validateStock(
  product: product,
  requestedQuantity: 5,
  existingOrders: currentOrders,
);

if (!result.isValid) {
  print(result.message); // "Stok Produk A tidak cukup. Tersedia: 3, Diminta: 5"
}
```

### 2. StockWarningDialog
Dialog peringatan untuk stok tidak cukup.

```dart
import 'package:fic23pos_flutter/core/components/stock_warning_dialog.dart';

// Menampilkan dialog peringatan
StockWarningDialog.show(
  context: context,
  result: validationResult,
  onAcceptSuggestion: (suggestedQuantity) {
    // Gunakan jumlah yang disarankan
    addToCart(product, suggestedQuantity);
  },
);

// Menampilkan dialog stok habis
StockWarningDialog.showOutOfStock(
  context: context,
  productName: product.name,
);
```

### 3. OrderHelpers
Helper untuk validasi stok yang lebih mudah digunakan.

```dart
import 'package:fic23pos_flutter/core/utils/order_helpers.dart';

// Validasi sebelum menambahkan ke keranjang
bool canAddToCart = OrderHelpers.validateAndShowStockWarning(
  context: context,
  product: product,
  requestedQuantity: quantity,
  existingOrders: currentOrders,
  onAcceptSuggestion: (suggestedQty) {
    addToCart(product, suggestedQty);
  },
);

// Mendapatkan pesan warning ringkas
String warningMessage = OrderHelpers.getStockWarningMessage(
  product: product,
  requestedQuantity: quantity,
);
```

### 4. StockSnackbar
SnackBar untuk pesan ringkas.

```dart
import 'package:fic23pos_flutter/core/components/stock_snackbar.dart';

// Pesan stok tidak cukup
StockSnackbar.showStockWarning(
  context: context,
  message: 'Stok tidak cukup untuk produk ini',
);

// Pesan stok habis
StockSnackbar.showOutOfStock(
  context: context,
  productName: 'Produk A',
);

// Pesan stok rendah
StockSnackbar.showLowStock(
  context: context,
  productName: 'Produk B',
  availableStock: 2,
);
```

### 5. ProductCardWithStock
Widget kartu produk dengan indikator stok.

```dart
import 'package:fic23pos_flutter/core/components/product_card_with_stock.dart';

ProductCardWithStock(
  product: product,
  onAddToCart: () => handleAddToCart(product),
  onQuantitySelected: (quantity) => handleQuantitySelection(product, quantity),
)
```

## Contoh Implementasi Lengkap

### Validasi saat menambahkan produk ke order

```dart
void addProductToOrder(BuildContext context, Product product, int quantity) {
  final currentOrders = getCurrentOrders(); // Ambil order yang sudah ada
  
  final isValid = OrderHelpers.validateAndShowStockWarning(
    context: context,
    product: product,
    requestedQuantity: quantity,
    existingOrders: currentOrders,
    onAcceptSuggestion: (suggestedQuantity) {
      // Jika user menerima saran, tambahkan dengan jumlah yang disarankan
      _addToOrder(product, suggestedQuantity);
    },
  );
  
  if (isValid) {
    _addToOrder(product, quantity);
  }
}
```

### Validasi saat checkout

```dart
bool validateAllOrders(BuildContext context, List<OrderItem> orders) {
  final results = StockValidator.validateMultipleStocks(orderItems: orders);
  
  final invalidOrders = results.where((result) => !result.isValid).toList();
  
  if (invalidOrders.isNotEmpty) {
    // Tampilkan pesan untuk order yang tidak valid
    for (final invalid in invalidOrders) {
      StockSnackbar.showStockWarning(
        context: context,
        message: invalid.message,
      );
    }
    return false;
  }
  
  return true;
}
```

## Pesan Error yang Tersedia

1. **Stok Habis**: "Maaf, produk [nama] sedang habis"
2. **Stok Tidak Cukup**: "Stok [nama] tidak cukup. Tersedia: [x], Diminta: [y]"
3. **Sudah Mencapai Batas**: "Produk [nama] sudah mencapai batas stok yang tersedia"
4. **Stok Tidak Tersedia**: "Stok produk tidak tersedia"

## Best Practices

1. **Selalu validasi stok sebelum menambahkan ke order**
2. **Gunakan dialog untuk kasus yang memerlukan konfirmasi user**
3. **Gunakan snackbar untuk pesan ringkas**
4. **Tampilkan indikator stok di UI produk**
5. **Berikan saran jumlah yang bisa dipesan jika stok tidak cukup**
