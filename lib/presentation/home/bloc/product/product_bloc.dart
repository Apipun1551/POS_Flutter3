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
  List<Product> filteredProducts = [];   // produk setelah filter search/kategori
  int? currentCategoryId;                // kategori aktif (null = semua)

  ProductBloc(this.productRemoteDatasource) : super(Initial()) {
    /// Fetch semua produk
    on<_FetchProducts>((event, emit) async {
      emit(Loading());
      final result = await productRemoteDatasource.getProducts();
      result.fold(
        (failure) => emit(Failure(failure)),
        (success) {
          products = success.data ?? [];
          filteredProducts = List.from(products);
          currentCategoryId = null;
          emit(Success(filteredProducts));
        },
      );
    });

    /// Fetch produk berdasarkan kategori
    on<_FetchProductsByCategory>((event, emit) async {
      emit(Loading());
      currentCategoryId = event.categoryId;
      final result = products
          .where((product) => product.categoryId == event.categoryId)
          .toList();
      filteredProducts = List.from(result);
      emit(Success(filteredProducts));
    });

    /// Search produk
    on<_SearchProducts>((event, emit) async {
      final query = event.query.toLowerCase();

      final sourceList = currentCategoryId != null
          ? products.where((p) => p.categoryId == currentCategoryId).toList()
          : products;

      if (query.isEmpty) {
        filteredProducts = List.from(sourceList);
      } else {
        filteredProducts = sourceList.where((product) {
          final productName = product.name?.toLowerCase() ?? '';
          final productDescription = product.description?.toLowerCase() ?? '';
          return productName.contains(query) || productDescription.contains(query);
        }).toList();
      }

      emit(Success(filteredProducts));
    });

    /// Add produk
    on<_AddProduct>((event, emit) async {
      emit(Loading());
      final result = await productRemoteDatasource.addProduct(event.product.toMap());
      result.fold(
        (failure) => emit(Failure(failure)),
        (_) => add(const ProductEvent.fetchProducts()),
      );
    });


    /// Update produk
    on<_UpdateProduct>((event, emit) async {
      emit(Loading());

      print('Mengupdate produk ID: ${event.product.id}');
      print('Data yang dikirim (debug): ${event.product.toMap()}');

      final result = await productRemoteDatasource.updateProduct(
        event.product.id!,         // id
        event.product,             // <-- kirim Product, bukan .toMap()
      );

      result.fold(
        (failure) {
          print('Error update: $failure');
          emit(Failure(failure));
        },
        (updatedProduct) {
          print('Update berhasil: ${updatedProduct.toMap()}');

          // Cara aman: fetch ulang dari server biar sinkron
          add(const ProductEvent.fetchProducts());

          // Kalau mau instan tanpa fetch, kamu bisa update list lokal seperti ini:
          // final i = products.indexWhere((p) => p.id == updatedProduct.id);
          // if (i != -1) products[i] = updatedProduct;
          // final j = filteredProducts.indexWhere((p) => p.id == updatedProduct.id);
          // if (j != -1) filteredProducts[j] = updatedProduct;
          // emit(Success(List.from(filteredProducts)));
        },
      );
    });


    /// Delete produk
    on<_DeleteProduct>((event, emit) async {
      emit(Loading());
      final result = await productRemoteDatasource.deleteProduct(event.productId);

      result.fold(
        (failure) => emit(Failure(failure)),
        (success) {
          // Opsi 1: langsung hapus dari list lokal (cepat)
          products.removeWhere((p) => p.id == event.productId);
          filteredProducts.removeWhere((p) => p.id == event.productId);
          emit(Success(List.from(filteredProducts)));

          // Opsi 2 (lebih aman): fetch ulang dari server
          // add(const ProductEvent.fetchProducts());
        },
      );
    });
  }
}