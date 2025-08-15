import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/core/constants/variables.dart';
import 'package:fic23pos_flutter/core/extensions/int_ext.dart';
import 'package:fic23pos_flutter/data/models/response/product_response_model.dart';
import 'package:fic23pos_flutter/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:fic23pos_flutter/presentation/home/models/order_item.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  final bool showStock;

  const ProductCard({
    Key? key,
    required this.data,
    this.showStock = false, // default false
  }) : super(key: key);
  //const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.read<CheckoutBloc>().add(CheckoutEvent.addCheckout(data));
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: AppColors.card),
                borderRadius: BorderRadius.circular(20),
              ),
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.disabled.withOpacity(0.4),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    child: CachedNetworkImage(
                      height: 50,
                      fit: BoxFit.fitWidth,
                      imageUrl: '${Variables.imageBaseUrl}${data.image}',
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.food_bank_outlined, size: 50),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  data.name ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SpaceHeight(8.0),
                // Tampilkan category atau stock tergantung showStock
                if (showStock)
                  Text(
                    'Stock: ${data.stock ?? 0}',
                    style: const TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                // else
                //   Text(
                //     data.category?.name ?? '',
                //     style: const TextStyle(color: AppColors.grey, fontSize: 12),
                //   ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        double.parse(data.price!).toInt().currencyFormatRpV2,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: AppColors.brand,
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            switch (state) {
              case Failure(message: String message):
                return Center(child: Text(message));
              case Success(
                products: List<OrderItem> products,
                total: int _,
                qty: int _,
              ):
                if (products.any((element) => element.product.id == data.id)) {
                  var index = products.indexWhere(
                    (element) => element.product.id == data.id,
                  );
                  return Positioned(
                    top: 18,
                    right: 18,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.brand,
                      child: Text(
                        products[index].quantity.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              case _:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
