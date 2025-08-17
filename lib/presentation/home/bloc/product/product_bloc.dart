import 'package:bloc/bloc.dart';
import 'package:fic23pos_flutter/data/models/response/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic23pos_flutter/data/datasource/product_remote_datasource.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  List<Product> products = [];           // semua produk
  List<Product> filteredProducts = [];   // produk setelah filter search atau kategori
  int? currentCategoryId;                // kategori yang sedang dipilih

  ProductBloc(this.productRemoteDatasource) : super(Initial()) {
    // fetch semua produk
    on<_FetchProducts>((event, emit) async {
      emit(Loading());
      final result = await productRemoteDatasource.getProducts();
      result.fold(
        (failure) => emit(Failure(failure)),
        (success) {
          products = success.data ?? [];
          filteredProducts = List.from(products);
          currentCategoryId = null; // reset kategori
          emit(Success(filteredProducts));
        },
      );
    });

    // fetch produk berdasarkan kategori
    on<_FetchProductsByCategory>((event, emit) async {
      emit(Loading());
      currentCategoryId = event.categoryId;
      final result = products
          .where((product) => product.categoryId == event.categoryId)
          .toList();
      filteredProducts = List.from(result);
      emit(Success(filteredProducts));
    });

    // search produk
    // on<_SearchProducts>((event, emit) async {
    //   final query = event.query.toLowerCase();

    //   // ambil list yang akan di-search: jika kategori dipilih, search di filteredProducts
    //   final sourceList = currentCategoryId != null
    //       ? products.where((p) => p.categoryId == currentCategoryId).toList()
    //       : products;

    //   if (query.isEmpty) {
    //     filteredProducts = List.from(sourceList);
    //   } else {
    //     filteredProducts = sourceList.where((product) {
    //       final productName = product.name?.toLowerCase() ?? '';
    //       final productDescription = product.description?.toLowerCase() ?? '';
    //       return productName.contains(query) || productDescription.contains(query);
    //     }).toList();
    //   }

    //   emit(Success(filteredProducts));
    // });
    // search produk
    on<_SearchProducts>((event, emit) async {
      final query = event.query.toLowerCase();

      // jika ada kategori yang dipilih, gunakan filteredProducts kategori sebagai sumber search
      // jika tidak ada kategori, gunakan semua produk
      final sourceList = currentCategoryId != null
          ? products.where((p) => p.categoryId == currentCategoryId).toList()
          : products;

      // jika query kosong, tampilkan semua produk sesuai kategori (atau semua produk)
      if (query.isEmpty) {
        filteredProducts = List.from(sourceList);
      } else {
        // filter produk berdasarkan nama atau deskripsi
        filteredProducts = sourceList.where((product) {
          final productName = product.name?.toLowerCase() ?? '';
          final productDescription = product.description?.toLowerCase() ?? '';
          return productName.contains(query) || productDescription.contains(query);
        }).toList();
      }

      emit(Success(filteredProducts));
    });

    // update produk
    on<_UpdateProduct>((event, emit) async {
      emit(Loading());
      
      // Update produk di local list
      final index = products.indexWhere((p) => p.id == event.product.id);
      if (index != -1) {
        products[index] = event.product;
        
        // Update filtered products juga
        final filteredIndex = filteredProducts.indexWhere((p) => p.id == event.product.id);
        if (filteredIndex != -1) {
          filteredProducts[filteredIndex] = event.product;
        }
        
        emit(Success(filteredProducts));
      } else {
        emit(Failure('Product not found'));
      }
    });
  }
}