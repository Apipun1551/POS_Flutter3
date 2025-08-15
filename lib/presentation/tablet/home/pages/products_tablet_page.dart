import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/core/assets/assets.gen.dart';
import 'package:fic23pos_flutter/core/components/spaces.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/core/extensions/build_context_ext.dart';
import 'package:fic23pos_flutter/presentation/home/bloc/product/product_bloc.dart' as product_bloc;
import 'package:fic23pos_flutter/presentation/home/widgets/product_card.dart';

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
                            // Implement search logic
                          },
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
                              //=> ProductCard(
                                //data: dummyProducts[index],
                                return ProductCard(
                                  data: dummyProducts[index],
                                  showStock: true, // stok hanya tampil di halaman ini
                                  showAddButton: false, //Button tidak tampil di halaman ini
                                );
                              //),
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
