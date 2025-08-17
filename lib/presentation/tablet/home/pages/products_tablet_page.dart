import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/core/assets/assets.gen.dart';
import 'package:fic23pos_flutter/core/components/spaces.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/core/extensions/build_context_ext.dart';
import 'package:fic23pos_flutter/data/models/response/product_response_model.dart';
import 'package:fic23pos_flutter/presentation/home/bloc/product/product_bloc.dart' as product_bloc;
import 'package:fic23pos_flutter/presentation/tablet/home/widgets/product_card_crud.dart';
import 'package:fic23pos_flutter/presentation/tablet/setting/dialogs/form_product_dialog.dart';

class ProductsTabletPage extends StatefulWidget {
  const ProductsTabletPage({super.key});

  @override
  State<ProductsTabletPage> createState() => _ProductsTabletPageState();
}

class _ProductsTabletPageState extends State<ProductsTabletPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<product_bloc.ProductBloc>().add(
      const product_bloc.ProductEvent.fetchProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      Text(
                        'Products',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brand,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            // Filter products based on search query
                            context.read<product_bloc.ProductBloc>().add(
                              product_bloc.ProductEvent.searchProducts(value),
                            );
                          },
                        ),
                      ),
                      const SpaceWidth(16),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const FormProductDialog(),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Product'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brand,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SpaceHeight(24),
                  
                  // Products Grid
                  Expanded(
                    child: BlocBuilder<
                      product_bloc.ProductBloc,
                      product_bloc.ProductState
                    >(
                      builder: (context, state) {
                        switch (state) {
                          case product_bloc.Loading():
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case product_bloc.Failure(
                            message: String message,
                          ):
                            return Center(child: Text(message));
                          case product_bloc.Success(
                            products: List dummyProducts,
                          ):
                            if (dummyProducts.isEmpty) {
                              return const Center(
                                child: Text('No products available'),
                              );
                            }
                            return GridView.builder(
                              //shrinkWrap: true, // biar ukurannya pas di dalam Expanded
                              physics: const BouncingScrollPhysics(), // biar tetap bisa scroll
                              itemCount: dummyProducts.length,
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250, // lebar max tiap card
                                //crossAxisCount: 4,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                //childAspectRatio: 0.9, // sedikit diperbesar biar konten muat
                              ),
                              itemBuilder: (context, index) {
                                return ProductCardCrud(
                                  data: dummyProducts[index],
                                );
                              }
                            );

                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Right Panel (Order Summary)
          // Expanded(
          //   flex: 2,
          //   child: Container(
          //     color: AppColors.white,
          //     child: const Center(
          //       child: Text(
          //         'Order Summary Products',
          //         style: TextStyle(fontSize: 18),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
