part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  const factory ProductEvent.fetchProducts() = _FetchProducts;
  //products by category
  const factory ProductEvent.fetchProductsByCategory(int categoryId) = _FetchProductsByCategory;
  //search products
  const factory ProductEvent.searchProducts(String query) = _SearchProducts;
  //add to cart
  const factory ProductEvent.addProduct(Product product) = _AddProduct;
  const factory ProductEvent.updateProduct(Product product) = _UpdateProduct;
  const factory ProductEvent.deleteProduct(int productId) = _DeleteProduct;
}
