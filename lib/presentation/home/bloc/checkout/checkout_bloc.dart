import 'package:bloc/bloc.dart';
import 'package:fic23pos_flutter/data/models/response/product_response_model.dart';
import 'package:fic23pos_flutter/presentation/home/models/order_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const Success([], 0, 0)) {
    on<_AddCheckout>((event, emit) {
      var currentStates = state as Success;
      List<OrderItem> newCheckout = [...currentStates.products];
      if (newCheckout.any(
        (element) => element.product.id == event.product.id,
      )) {
        var index = newCheckout.indexWhere(
          (element) => element.product.id == event.product.id,
        );
        newCheckout[index].quantity++;
      } else {
        newCheckout.add(OrderItem(product: event.product, quantity: 1));
      }
      int totalQuantity = 0;
      int totalPrice = 0;
      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        totalPrice +=
            // element.quantity * (element.product.price ?? 0);
          element.quantity * (element.product.price ?? 0).toInt();

      }
      emit(Success(newCheckout, totalPrice, totalQuantity));
    });

    on<_RemoveCheckout>((event, emit) {
      var currentStates = state as Success;
      List<OrderItem> newCheckout = [...currentStates.products];

      if (newCheckout.any(
        (element) => element.product.id == event.product.id,
      )) {
        var index = newCheckout.indexWhere(
          (element) => element.product.id == event.product.id,
        );
        if (newCheckout[index].quantity > 1) {
          newCheckout[index].quantity--;
        } else {
          newCheckout.removeAt(index);
        }
      }
      int totalQuantity = 0;
      int totalPrice = 0;
      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        totalPrice +=
          element.quantity * (element.product.price ?? 0).toInt();
      }
      emit(Success(newCheckout, totalPrice, totalQuantity));
    });

    on<_Started>((event, emit) {
      emit(const Success([], 0, 0));
    });
  }
}
