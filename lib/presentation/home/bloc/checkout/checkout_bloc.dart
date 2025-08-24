import 'package:bloc/bloc.dart';
import 'package:fic23pos_flutter/data/models/response/product_response_model.dart';
import 'package:fic23pos_flutter/presentation/home/models/order_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const Success(products: [], total: 0, qty: 0)) {
    
    on<_AddCheckout>((event, emit) {
      final currentState = state as Success;
      final newCheckout = [...currentState.products];

      if (newCheckout.any((e) => e.product.id == event.product.id)) {
        final index = newCheckout.indexWhere((e) => e.product.id == event.product.id);
        newCheckout[index] = newCheckout[index].copyWith(
          quantity: newCheckout[index].quantity + 1,
        );
      } else {
        newCheckout.add(OrderItem(product: event.product, quantity: 1));
      }

      emit(
        currentState.copyWith(
          products: newCheckout,
          qty: newCheckout.fold(0, (sum, item) => sum + item.quantity),
          total: newCheckout.fold(0, (sum, item) => sum + (item.product.price ?? 0).toInt() * item.quantity),
        ),
      );
    });

    on<UpdateCheckout>((event, emit) {
      final currentState = state as Success;
      final updatedProducts = [...currentState.products];

      final index = updatedProducts.indexWhere((item) => item.product.id == event.product.id);
      if (index != -1) {
        if (event.qty > 0) {
          updatedProducts[index] = updatedProducts[index].copyWith(quantity: event.qty);
        } else {
          updatedProducts.removeAt(index);
        }
      }

      emit(
        currentState.copyWith(
          products: updatedProducts,
          qty: updatedProducts.fold(0, (sum, item) => sum + item.quantity),
          total: updatedProducts.fold(0, (sum, item) => sum + (item.product.price ?? 0).toInt() * item.quantity),
        ),
      );
    });

    on<_RemoveCheckout>((event, emit) {
      final currentState = state as Success;
      final newCheckout = [...currentState.products];

      if (newCheckout.any((e) => e.product.id == event.product.id)) {
        final index = newCheckout.indexWhere((e) => e.product.id == event.product.id);
        if (newCheckout[index].quantity > 1) {
          newCheckout[index] = newCheckout[index].copyWith(
            quantity: newCheckout[index].quantity - 1,
          );
        } else {
          newCheckout.removeAt(index);
        }
      }

      emit(
        currentState.copyWith(
          products: newCheckout,
          qty: newCheckout.fold(0, (sum, item) => sum + item.quantity),
          total: newCheckout.fold(0, (sum, item) => sum + (item.product.price ?? 0).toInt() * item.quantity),
        ),
      );
    });

    on<_Started>((event, emit) {
      emit(const Success(products: [], total: 0, qty: 0));
    });
  }
}
