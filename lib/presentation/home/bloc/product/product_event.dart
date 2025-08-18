part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  const factory ProductEvent.fetchProducts() = _FetchProducts;
  const factory ProductEvent.fetchProductsByCategory(int categoryId) = _FetchProductsByCategory;
  const factory ProductEvent.searchProducts(String query) = _SearchProducts;
  const factory ProductEvent.addProduct(Product product) = _AddProduct;
  const factory ProductEvent.updateProduct(Product product) = _UpdateProduct;
  const factory ProductEvent.deleteProduct(int productId) = _DeleteProduct;
}