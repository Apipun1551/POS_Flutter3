import 'package:flutter/material.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/data/models/response/product_response_model.dart';
import 'package:fic23pos_flutter/core/utils/order_helpers.dart';

class ProductCardWithStock extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;
  final Function(int quantity)? onQuantitySelected;

  const ProductCardWithStock({
    super.key,
    required this.product,
    this.onAddToCart,
    this.onQuantitySelected,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = OrderHelpers.isProductAvailable(product);
    final stock = product.stock ?? 0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    color: Colors.grey[200],
                  ),
                  child: product.image != null
                      ? Image.network(
                          product.image!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : const Icon(Icons.image, size: 50),
                ),
              ),
              
              // Product Info
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? 'Produk',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${product.price ?? '0'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Stock Indicator
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStockColor(stock),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getStockText(stock),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Out of Stock Overlay
          if (!isAvailable)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'STOK HABIS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getStockColor(int stock) {
    if (stock == 0) return Colors.red;
    if (stock <= 5) return Colors.orange;
    return Colors.green;
  }

  String _getStockText(int stock) {
    if (stock == 0) return 'Habis';
    if (stock <= 5) return 'Stok: $stock';
    return 'Stok: $stock';
  }
}
