import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic23pos_flutter/data/datasource/order_remote_datasource.dart';
import 'package:fic23pos_flutter/data/models/request/order_request_model.dart';
import 'package:fic23pos_flutter/data/models/response/order_response_model.dart'
    hide OrderItemModel;
import 'package:fic23pos_flutter/presentation/home/models/order_item.dart';

part 'order_bloc.freezed.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  OrderBloc(this.orderRemoteDatasource)
    : super(const Success('', 0, [], 0, 0)) {
    on<_AddPaymentMethod>((event, emit) async {
      emit(const Loading());
      try {
        // Simulate a delay for loading
        await Future.delayed(const Duration(seconds: 1));

        // Emit success state with payment method and order details
        emit(
          Success(
            event.paymentMethod,
            0, // Nominal bayar is not set yet
            event.orders,
            event.totalQuantity,
            event.totalPrice,
          ),
        );
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });

    on<_AddNominal>((event, emit) {
      var currentState = state as Success;
      // Update the nominal bayar in the current state
      emit(
        Success(
          currentState.paymentMethod,
          event.nominalBayar,
          currentState.orders,
          currentState.totalQuantity,
          currentState.totalPrice,
        ),
      );
    });

    on<_Started>((event, emit) {
      emit(const Success('', 0, [], 0, 0));
    });

    on<_AddOrder>((event, emit) async {
      var currentState = state as Success;
      try {
        final response = await orderRemoteDatasource.order(event.order);
        response.fold((failure) => emit(Failure(failure)), (orderResponse) {
          if (orderResponse.data != null) {
            emit(
              Success(
                currentState.paymentMethod,
                currentState.nominalBayar,
                currentState.orders,
                currentState.totalQuantity,
                currentState.totalPrice,
              ),
            );
          } else {
            emit(Failure(orderResponse.message ?? 'Unknown error'));
          }
        });
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });
  }
}
