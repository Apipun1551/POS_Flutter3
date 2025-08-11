part of 'order_bloc.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.started() = _Started;
  const factory OrderEvent.addPaymentMethod(
    String paymentMethod,
    List<OrderItem> orders,
    int totalQuantity,
    int totalPrice,
  ) = _AddPaymentMethod;

  //addNominal
  const factory OrderEvent.addNominal(int nominalBayar) = _AddNominal;

  //addOrder
  const factory OrderEvent.addOrder(OrderRequestModel order) = _AddOrder;
}
