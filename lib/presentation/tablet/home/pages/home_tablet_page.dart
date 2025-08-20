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
  int finalTotalPrice = 0;

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

    // context.read<ProductBloc>().add(ProductEvent.fetchByCategory(categoryId));
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
    tableNumberController.dispose();
    orderNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'confirmation_screen',
      child: Scaffold(
        body: Row(
          children: [
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
                            // Filter products based on search query
                            context.read<product_bloc.ProductBloc>().add(
                              product_bloc.ProductEvent.searchProducts(value),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        // SizedBox(
                        //   width: context.deviceWidth,
                        //   height: 84,
                        //   child: ListView(
                        //     scrollDirection: Axis.horizontal,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.only(right: 8.0),
                        //         child: SizedBox(
                        //           width: 120,
                        //           height: 84,
                        //           child: MenuButton(
                        //             size: 30,
                        //             iconPath: Assets.icons.parfum.path,//all icon
                        //             label: 'All',
                        //             isImage: false,
                        //             isActive: indexValue == 0,
                        //             onPressed: () {
                        //               onCategoryTap(0);
                        //               context.read<product_bloc.ProductBloc>().add(
                        //                 const product_bloc.ProductEvent.fetchProducts(),
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //       BlocBuilder<CategoryBloc, CategoryState>(
                        //         builder: (context, state) {
                        //           switch (state) {
                        //             case Loading():
                        //               return const Center(
                        //                 child: CircularProgressIndicator(),
                        //               );
                        //             case Failure(message: String message):
                        //               return Center(child: Text(message));
                        //             case Success(
                        //               categories: List<Category> categories,
                        //             ):
                        //               final cat =
                        //                   categories.map((e) {
                        //                     int index =
                        //                         categories.indexOf(e) + 1;
                        //                     return Padding(
                        //                       padding:
                        //                           const EdgeInsets.symmetric(
                        //                             horizontal: 8.0,
                        //                           ),
                        //                       child: SizedBox(
                        //                         width: 120,
                        //                         height: 84,
                        //                         child: MenuButton(
                        //                           iconPath:
                        //                               Assets
                        //                                   .icons
                        //                                   .parfum //other category
                        //                                   .path,
                        //                           label:
                        //                               categories[index - 1]
                        //                                   .name ??
                        //                               'Category $index',
                        //                           isActive: indexValue == index,
                        //                           isImage: false,
                        //                           onPressed: () {
                        //                             context
                        //                                 .read<
                        //                                   product_bloc.ProductBloc
                        //                                 >()
                        //                                 .add(
                        //                                   product_bloc
                        //                                       .ProductEvent.fetchProductsByCategory(
                        //                                     e.id!,
                        //                                   ),
                        //                                 );
                        //                             onCategoryTap(index);
                        //                           },
                        //                           size: 30,
                        //                         ),
                        //                       ),
                        //                     );
                        //                   }).toList();
                        //               return Row(children: cat);

                        //             case _:
                        //               return const Text('no data');
                        //           }
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const SpaceHeight(35.0),

                        // search
                        // BlocBuilder<product_bloc.ProductBloc, product_bloc.ProductState>(
                        //   builder: (context, state) {
                        //     if (state is product_bloc.Loading) {
                        //       return const Center(child: CircularProgressIndicator());
                        //     } else if (state is product_bloc.Failure) {
                        //       return Center(child: Text(state.message));
                        //     } else if (state is product_bloc.Success) {
                        //       final productsToShow = state.products;
                        //       if (productsToShow.isEmpty) {
                        //         return const Center(child: Text('No products available'));
                        //       }
                        //       return GridView.builder(
                        //         shrinkWrap: true,
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         itemCount: productsToShow.length,
                        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //           childAspectRatio: 0.8,
                        //           crossAxisCount: 3,
                        //           crossAxisSpacing: 16.0,
                        //           mainAxisSpacing: 16.0,
                        //         ),
                        //         itemBuilder: (context, index) => ProductCard(
                        //           data: productsToShow[index],
                        //         ),
                        //       );
                        //     } else {
                        //       return const SizedBox.shrink();
                        //     }
                        //   },
                        // ),

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

                        // BlocBuilder<
                        //   product_bloc.ProductBloc,
                        //   product_bloc.ProductState
                        // >(
                        //   builder: (context, state) {
                        //     switch (state) {
                        //       case product_bloc.Loading():
                        //         return const Center(
                        //           child: CircularProgressIndicator(),
                        //         );
                        //       case product_bloc.Failure(
                        //         message: String message,
                        //       ):
                        //         return Center(child: Text(message));
                        //       case product_bloc.Success(
                        //         products: List dummyProducts,
                        //       ):
                        //         if (dummyProducts.isEmpty) {
                        //           return const Center(
                        //             child: Text('No products available'),
                        //           );
                        //         } else {
                        //           return GridView.builder(
                        //             shrinkWrap: true,
                        //             physics:
                        //                 const NeverScrollableScrollPhysics(),
                        //             itemCount: dummyProducts.length,
                        //             gridDelegate:
                        //                 const SliverGridDelegateWithFixedCrossAxisCount(
                        //                   childAspectRatio: 0.8,
                        //                   crossAxisCount: 3,
                        //                   crossAxisSpacing: 16.0,
                        //                   mainAxisSpacing: 16.0,
                        //                 ),
                        //             itemBuilder:
                        //                 (context, index) => ProductCard(
                        //                   data: dummyProducts[index],
                        //                 ),
                        //           );
                        //         }

                        //       default:
                        //         return const SizedBox.shrink();
                        //     }
                        //   },
                        // ),

                        const SpaceHeight(30.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Right
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
                          width: 50.0,
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
                      child: BlocBuilder<
                          checkout_bloc.CheckoutBloc,
                          checkout_bloc.CheckoutState>(
                        builder: (context, state) {
                          switch (state) {
                            case checkout_bloc.Success(
                              products: List products,
                              total: int _,
                              qty: int qty,
                            ):
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
                                      itemBuilder: (context, index) => OrderMenu(
                                        data: products[index],
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const SpaceHeight(1.0),
                                      itemCount: products.length,
                                    );
                            case _:
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
                              onPressed: () {
                                indexValuePayment.value = 1;
                                // kirim event ke bloc
                              },
                            ),
                          ),
                          const SpaceWidth(16),
                          Flexible(
                            child: MenuButton(
                              iconPath: Assets.icons.qrCode.path,
                              label: 'QR',
                              isActive: value == 2,
                              onPressed: () {
                                indexValuePayment.value = 2;
                              },
                            ),
                          ),
                          const SpaceWidth(16),
                          Flexible(
                            child: MenuButton(
                              iconPath: Assets.icons.debit.path,
                              label: 'TRANSFER',
                              isActive: value == 3,
                              onPressed: () {
                                indexValuePayment.value = 3;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SpaceHeight(8),
                    const Divider(),
                    const SpaceHeight(8),

                    // === Total + Tombol Payment (selalu nempel bawah) ===
                    BlocBuilder<checkout_bloc.CheckoutBloc, checkout_bloc.CheckoutState>(
                      builder: (context, state) {
                        int total = state is checkout_bloc.Success ? state.total : 0;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    color: AppColors.brand,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  total.currencyFormatRp,
                                  style: const TextStyle(
                                    color: AppColors.brand,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SpaceHeight(16),
                            Button.filled(
                              onPressed: () {
                                // Payment logic
                              },
                              label: 'Payment',
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
