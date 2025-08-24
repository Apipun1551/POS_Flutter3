import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/core/assets/assets.gen.dart';
import 'package:fic23pos_flutter/core/components/buttons.dart';
import 'package:fic23pos_flutter/core/components/menu_button.dart';
import 'package:fic23pos_flutter/core/components/spaces.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/core/extensions/build_context_ext.dart';
import 'package:fic23pos_flutter/core/extensions/int_ext.dart';
import 'package:fic23pos_flutter/data/models/response/category_response_model.dart';
import 'package:fic23pos_flutter/presentation/home/bloc/category/category_bloc.dart';
import 'package:fic23pos_flutter/presentation/home/bloc/checkout/checkout_bloc.dart'
    as checkout_bloc;
import 'package:fic23pos_flutter/presentation/home/widgets/product_card.dart';
import 'package:fic23pos_flutter/presentation/order/widgets/payment_cash_dialog.dart';
import 'package:fic23pos_flutter/presentation/tablet/home/pages/dashboard_tablet_page.dart';
import 'package:fic23pos_flutter/presentation/tablet/home/widgets/home_title.dart';
import 'package:fic23pos_flutter/presentation/home/bloc/product/product_bloc.dart'
    as product_bloc;
import '../../../home/models/order_item.dart';
import '../../../order/bloc/order/order_bloc.dart' as order_bloc;
import '../widgets/order_menu.dart';

class HomeTabletPage extends StatefulWidget {
  const HomeTabletPage({super.key});

  @override
  State<HomeTabletPage> createState() => _HomeTabletPageState();
}

class _HomeTabletPageState extends State<HomeTabletPage> {
  final searchController = TextEditingController();
  final tableNumberController = TextEditingController();
  final orderNameController = TextEditingController();
  final indexValuePayment = ValueNotifier(0);
  bool isOpenBill = false;
  int indexValue = 0;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(const CategoryEvent.fetchCategories());
    context.read<product_bloc.ProductBloc>().add(
      const product_bloc.ProductEvent.fetchProducts(),
    );
  }

  void onCategoryTap(int index) {
    searchController.clear();
    indexValue = index;
    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    tableNumberController.dispose();
    orderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'confirmation_screen',
      child: Scaffold(
        resizeToAvoidBottomInset: false, // supaya layout tidak ikut naik saat keyboard muncul
        body: Row(
          children: [
            // =================== LEFT PANEL ===================
            Expanded(
              flex: 3,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HomeTitle(
                          controller: searchController,
                          onChanged: (value) {
                            context.read<product_bloc.ProductBloc>().add(
                                  product_bloc.ProductEvent.searchProducts(value),
                                );
                          },
                        ),
                        const SizedBox(height: 24),

                        BlocBuilder<product_bloc.ProductBloc, product_bloc.ProductState>(
                          builder: (context, state) {
                            if (state is product_bloc.Loading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is product_bloc.Failure) {
                              developer.log('ProductBloc Failure: ${state.message}');
                              return Center(child: Text(state.message));
                            } else if (state is product_bloc.Success) {
                              final productsToShow = state.products;
                              developer.log('UI shows products: ${productsToShow.length}');
                              if (productsToShow.isEmpty) {
                                return const Center(child: Text('No products available'));
                              }
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: productsToShow.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.8,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                ),
                                itemBuilder: (context, index) => ProductCard(
                                  data: productsToShow[index],
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),

                        const SpaceHeight(30.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // =================== RIGHT PANEL (Orders) ===================
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    const Row(
                      children: [
                        Text(
                          'Orders #',
                          style: TextStyle(
                            color: AppColors.brand,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SpaceHeight(16.0),

                    // Judul kolom
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Item',
                          style: TextStyle(
                            color: AppColors.brand,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 130),
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            'Qty',
                            style: TextStyle(
                              color: AppColors.brand,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'Price',
                          style: TextStyle(
                            color: AppColors.brand,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SpaceHeight(8),
                    const Divider(),
                    const SpaceHeight(8),

                    // === Bagian produk (scrollable) ===
                    Expanded(
                      child: BlocBuilder<checkout_bloc.CheckoutBloc, checkout_bloc.CheckoutState>(
                        builder: (context, state) {
                          if (state is checkout_bloc.Success) {
                            final products = state.products;
                            final qty = state.qty;

                            return qty == 0
                                ? const Center(
                                    child: Text(
                                      'No items in the cart',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  )
                                : ListView.separated(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).viewInsets.bottom + 180, // buat footer
                                    ),
                                    itemBuilder: (context, index) {
                                      final item = products[index];
                                      return Row(
                                        children: [
                                          Expanded(
                                            flex: 2, // nama produk ambil 3x ruang
                                            child: Text(
                                              item.product.name ?? '-',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // Tombol minus
                                                InkWell(
                                                  // Tombol minus
                                                  onTap: () {
                                                    final newQty = item.quantity - 1;
                                                    context.read<checkout_bloc.CheckoutBloc>().add(
                                                          checkout_bloc.UpdateCheckout(item.product, newQty),
                                                        );
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey.shade200,
                                                    ),
                                                    child: const Icon(Icons.remove, size: 18),
                                                  ),
                                                ),
                                                const SizedBox(width: 6),

                                                // Angka qty
                                                InkWell(
                                                  onTap: () async {
                                                    // Bisa tetap buka dialog jika mau edit manual
                                                    final newQty = await showDialog<int>(
                                                      context: context,
                                                      builder: (_) => AlertDialog(
                                                        title: const Text("Edit Quantity"),
                                                        content: TextField(
                                                          autofocus: true,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            hintText: item.quantity.toString(),
                                                          ),
                                                          onSubmitted: (val) {
                                                            Navigator.of(context).pop(int.tryParse(val) ?? item.quantity);
                                                          },
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () => Navigator.of(context).pop(item.quantity),
                                                            child: const Text("Cancel"),
                                                          ),
                                                        ],
                                                      ),
                                                    );

                                                    if (newQty != null && newQty != item.quantity) {
                                                      context.read<checkout_bloc.CheckoutBloc>().add(
                                                            checkout_bloc.UpdateCheckout(item.product, newQty),
                                                          );
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                                                    child: Text(
                                                      item.quantity.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(width: 6),
                                                // Tombol plus
                                                InkWell(
                                                  onTap: () {
                                                    final newQty = item.quantity + 1;
                                                    context.read<checkout_bloc.CheckoutBloc>().add(
                                                          checkout_bloc.UpdateCheckout(item.product, newQty),
                                                        );
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey.shade200,
                                                    ),
                                                    child: const Icon(Icons.add, size: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1, // price
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(item.product.price?.currencyFormatRp ?? '-'),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                                    itemCount: products.length,
                                  );
                                //   ListView.separated(
                                //     padding: EdgeInsets.only(
                                //       bottom: MediaQuery.of(context)
                                //               .viewInsets
                                //               .bottom +
                                //           180, // 👈 kasih ruang buat footer
                                //     ),
                                //     itemBuilder: (context, index) => OrderMenu(
                                //       data: products[index],
                                //     ),
                                //     separatorBuilder: (context, index) => const SpaceHeight(1.0),
                                //     itemCount: products.length,
                                //   );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),

                    const SpaceHeight(8),
                    const Divider(),
                    const SpaceHeight(8),

                    // === Metode Pembayaran ===
                    ValueListenableBuilder(
                      valueListenable: indexValuePayment,
                      builder: (context, value, _) => Row(
                        children: [
                          Flexible(
                            child: MenuButton(
                              iconPath: Assets.icons.cash.path,
                              label: 'CASH',
                              isActive: value == 1,
                              onPressed: () => indexValuePayment.value = 1,
                            ),
                          ),
                          const SpaceWidth(16),
                          Flexible(
                            child: MenuButton(
                              iconPath: Assets.icons.qrCode.path,
                              label: 'QR',
                              isActive: value == 2,
                              onPressed: () => indexValuePayment.value = 2,
                            ),
                          ),
                          const SpaceWidth(16),
                          Flexible(
                            child: MenuButton(
                              iconPath: Assets.icons.debit.path,
                              label: 'TRANSFER',
                              isActive: value == 3,
                              onPressed: () => indexValuePayment.value = 3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SpaceHeight(8),
                    const Divider(),
                    const SpaceHeight(8),

                    // === Total + Tombol Payment — Ditempel di bawah, tidak ikut SafeArea (agar tidak naik) ===
                    BlocBuilder<checkout_bloc.CheckoutBloc, checkout_bloc.CheckoutState>(
                      builder: (context, state) {
                        final int finalTotalPrice =
                            state is checkout_bloc.Success ? state.total : 0;
                        final products = state is checkout_bloc.Success
                            ? state.products
                            : <OrderItem>[];
                        final qty = state is checkout_bloc.Success ? state.qty : 0;

                        return ColoredBox(
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // --- Total order ---
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total',
                                      style: TextStyle(
                                        color: AppColors.brand,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      finalTotalPrice.currencyFormatRp,
                                      style: const TextStyle(
                                        color: AppColors.brand,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SpaceHeight(12.0),

                                // --- Tombol Payment ---
                                Button.filled(
                                  onPressed: () {
                                    if (indexValuePayment.value == 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Silakan pilih metode pembayaran'),
                                          backgroundColor: AppColors.brand,
                                        ),
                                      );
                                      return;
                                    }

                                    if (state is checkout_bloc.Success) {
                                      // Kirim event ke OrderBloc
                                      context.read<order_bloc.OrderBloc>().add(
                                            order_bloc.OrderEvent.addPaymentMethod(
                                              indexValuePayment.value == 1
                                                  ? 'CASH'
                                                  : indexValuePayment.value == 2
                                                      ? 'QR'
                                                      : 'TRANSFER',
                                              products,
                                              qty,
                                              finalTotalPrice,
                                            ),
                                          );

                                      developer.log('Final Total Price: $finalTotalPrice');
                                      developer.log('Products: $products');

                                      // Tampilkan dialog Payment (tetap dialog, bukan push page)
                                      showDialog(
                                        context: context,
                                        builder: (_) => PaymentCashDialog(
                                          price: finalTotalPrice,
                                          isTablet: true,
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Order belum siap'),
                                          backgroundColor: AppColors.brand,
                                        ),
                                      );
                                    }
                                  },
                                  label: 'Payment',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}