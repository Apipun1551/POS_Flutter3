import 'package:flutter/material.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/core/utils/stock_validator.dart';

class StockWarningDialog {
  static void show({
    required BuildContext context,
    required StockValidationResult result,
    VoidCallback? onAcceptSuggestion,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.warning_rounded,
                color: Colors.red,
                size: 28,
              ),
              const SizedBox(width: 8),
              const Text(
                'Peringatan Stok',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                result.message,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Info Stok:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Stok Tersedia: ${result.availableStock}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Jumlah Diminta: ${result.requestedQuantity}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    if (result.hasSuggestion) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Saran: Gunakan ${result.suggestedQuantity} pcs',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          actions: [
            if (result.hasSuggestion && onAcceptSuggestion != null)
              TextButton(
                onPressed: onAcceptSuggestion,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Gunakan Jumlah Saran'),
              ),
            TextButton(
              onPressed: onCancel ?? () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  static void showOutOfStock({
    required BuildContext context,
    required String productName,
    VoidCallback? onClose,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.cancel_rounded,
                color: Colors.red,
                size: 28,
              ),
              const SizedBox(width: 8),
              const Text(
                'Stok Habis',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          content: Text(
            'Maaf, produk "$productName" sedang habis. Silakan pilih produk lain.',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: onClose ?? () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Mengerti'),
            ),
          ],
        );
      },
    );
  }
}
