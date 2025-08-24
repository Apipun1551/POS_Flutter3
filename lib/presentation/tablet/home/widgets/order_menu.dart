import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/core/components/spaces.dart';
import 'package:fic23pos_flutter/core/constants/variables.dart';
import 'package:fic23pos_flutter/core/extensions/int_ext.dart';
import 'package:fic23pos_flutter/presentation/home/models/order_item.dart';

import '../../../../core/constants/colors.dart';
import '../../../home/bloc/checkout/checkout_bloc.dart';

class OrderMenu extends StatelessWidget {
  final OrderItem data;
  const OrderMenu({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // final qtyController = TextEditingController(text: '3');

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  child: CachedNetworkImage(
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                    imageUrl: '${Variables.imageBaseUrl}${data.product.image}',
                    placeholder:
                        (context, url) => const CircularProgressIndicator(),
                    errorWidget:
                        (context, url, error) =>
                          Image.asset(
                            'assets/images/parfum.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                title: Text(
                  data.product.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text('Rp ${(data.product.price ?? 0).currencyFormatRp}'),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<CheckoutBloc>().add(
                      CheckoutEvent.removeCheckout(data.product),
                    );
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: AppColors.white,
                    child: const Icon(
                      Icons.remove_circle,
                      color: AppColors.brand,
                    ),
                  ),
                ),
                SizedBox(
                  //width: 30.0,
                  // child: Center(child: Text(data.quantity.toString())),
                  width :50.0,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: data.quantity.toString()),
                    onSubmitted: (value) {
                      final newQty = int.tryParse(value) ?? data.quantity;
                      if (newQty > 0) {
                        context.read<CheckoutBloc>().add(
                          CheckoutEvent.updateCheckout(data.product, newQty),
                        );
                      } else {
                        // kalau 0, bisa langsung remove product
                        context.read<CheckoutBloc>().add(
                          CheckoutEvent.removeCheckout(data.product),
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<CheckoutBloc>().add(
                      CheckoutEvent.addCheckout(data.product),
                    );
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: AppColors.white,
                    child: const Icon(
                      Icons.add_circle,
                      color: AppColors.brand,
                    ),
                  ),
                ),
              ],
            ),
            const SpaceWidth(8),
            SizedBox(
              width: 80.0,
              child: Text(
                ((data.product.price ?? 0) * data.quantity)
                    .currencyFormatRp,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.brand,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SpaceHeight(16),
        // Row(
        //   children: [
        //     Flexible(
        //       child: TextFormField(
        //         controller: noteController,
        //         decoration: InputDecoration(
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(8.0),
        //           ),
        //           hintText: 'Catatan pesanan',
        //         ),
        //       ),
        //     ),
        //     const SpaceWidth(12),
        //     GestureDetector(
        //       onTap: () {},
        //       child: Container(
        //         padding: const EdgeInsets.all(16.0),
        //         height: 60.0,
        //         width: 60.0,
        //         decoration: const BoxDecoration(
        //           color: AppColors.brand,
        //           borderRadius: BorderRadius.all(Radius.circular(8.0)),
        //         ),
        //         child: Assets.icons.delete.svg(
        //           colorFilter:
        //               const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
