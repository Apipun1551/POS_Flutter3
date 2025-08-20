import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/core/extensions/build_context_ext.dart';
import 'package:fic23pos_flutter/core/extensions/int_ext.dart';
import '../../../core/extensions/string_ext.dart';
import 'package:fic23pos_flutter/data/datasource/auth_local_datasource.dart';
import 'package:fic23pos_flutter/data/models/request/order_request_model.dart';
import 'package:fic23pos_flutter/presentation/order/bloc/order/order_bloc.dart';
import 'package:fic23pos_flutter/presentation/order/widgets/payment_success_dialog.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class PaymentCashDialog extends StatefulWidget {
  final bool isTablet; // Untuk membedakan layout tablet / mobile
  final int price; // Total harga yang harus dibayar

  const PaymentCashDialog({
    super.key,
    required this.price,
    this.isTablet = false,
  });

  @override
  State<PaymentCashDialog> createState() => _PaymentCashDialogState();
}

class _PaymentCashDialogState extends State<PaymentCashDialog> {
  late TextEditingController priceController; // Controller input bayar
  int change = 0; // Variabel kembalian

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(
      text: widget.price.currencyFormatRp,
    );
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Stack(
        children: [
          // Tombol close
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.highlight_off),
            color: AppColors.brand,
          ),
          // Tampilkan metode pembayaran di tengah
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  String paymentMethod = state is Success
                      ? state.paymentMethod
                      : 'Cash';
                  return Text(
                    paymentMethod,
                    style: const TextStyle(
                      color: AppColors.brand,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: context.deviceWidth * 0.5, // Lebar dialog
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceHeight(16.0),

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
                  widget.price.currencyFormatRp,
                  style: const TextStyle(
                    color: AppColors.brand,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SpaceHeight(16.0),

            // --- Input nominal bayar ---
            CustomTextField(
              controller: priceController,
              label: 'Bayar',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final int priceValue = value.toIntegerFromText;
                priceController.text = priceValue.currencyFormatRp;
                priceController.selection = TextSelection.fromPosition(
                  TextPosition(offset: priceController.text.length),
                );

                // Hitung kembalian
                setState(() {
                  change = priceValue - widget.price;
                  if (change < 0) change = 0;
                });
              },
            ),

            const SpaceHeight(16.0),

            // --- Tampilkan kembalian jika ada ---
            if (change > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Change',
                    style: TextStyle(
                      color: AppColors.brand,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    change.currencyFormatRp,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

            const SpaceHeight(30.0),

            // --- Tombol bayar ---
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                return Button.filled(
                  onPressed: () async {
                    // Validasi input kosong
                    if (priceController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please input the price'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    // Validasi bayar kurang dari total
                    if (priceController.text.toIntegerFromText < widget.price) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                              'The nominal is less than the total price'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    // Ambil data user dari local auth
                    final authData = await AuthLocalDatasource().getAuthData();
                    String paymentMethod =
                        state is Success ? state.paymentMethod : 'Cash';
                    int cashierId = authData!.user!.id!;

                    // Buat model order
                    OrderRequestModel orderRequest = OrderRequestModel(
                      cashierId: cashierId,
                      paymentMethod: paymentMethod,
                      items: state is Success
                          ? state.orders
                              .map((order) => Item(
                                    productId: order.product.id,
                                    quantity: order.quantity,
                                  ))
                              .toList()
                          : [],
                    );

                    // Kirim event ke OrderBloc
                    context
                        .read<OrderBloc>()
                        .add(OrderEvent.addOrder(orderRequest));

                    // Tampilkan dialog sukses pembayaran
                    showDialog(
                      context: context,
                      builder: (_) =>
                          PaymentSuccessDialog(isTablet: widget.isTablet),
                    );
                  },
                  label: 'Pay',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}