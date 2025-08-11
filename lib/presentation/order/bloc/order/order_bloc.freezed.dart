// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent()';
}


}

/// @nodoc
class $OrderEventCopyWith<$Res>  {
$OrderEventCopyWith(OrderEvent _, $Res Function(OrderEvent) __);
}


/// @nodoc


class _Started implements OrderEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.started()';
}


}




/// @nodoc


class _AddPaymentMethod implements OrderEvent {
  const _AddPaymentMethod(this.paymentMethod, final  List<OrderItem> orders, this.totalQuantity, this.totalPrice): _orders = orders;
  

 final  String paymentMethod;
 final  List<OrderItem> _orders;
 List<OrderItem> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

 final  int totalQuantity;
 final  int totalPrice;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddPaymentMethodCopyWith<_AddPaymentMethod> get copyWith => __$AddPaymentMethodCopyWithImpl<_AddPaymentMethod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddPaymentMethod&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&const DeepCollectionEquality().equals(other._orders, _orders)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice));
}


@override
int get hashCode => Object.hash(runtimeType,paymentMethod,const DeepCollectionEquality().hash(_orders),totalQuantity,totalPrice);

@override
String toString() {
  return 'OrderEvent.addPaymentMethod(paymentMethod: $paymentMethod, orders: $orders, totalQuantity: $totalQuantity, totalPrice: $totalPrice)';
}


}

/// @nodoc
abstract mixin class _$AddPaymentMethodCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$AddPaymentMethodCopyWith(_AddPaymentMethod value, $Res Function(_AddPaymentMethod) _then) = __$AddPaymentMethodCopyWithImpl;
@useResult
$Res call({
 String paymentMethod, List<OrderItem> orders, int totalQuantity, int totalPrice
});




}
/// @nodoc
class __$AddPaymentMethodCopyWithImpl<$Res>
    implements _$AddPaymentMethodCopyWith<$Res> {
  __$AddPaymentMethodCopyWithImpl(this._self, this._then);

  final _AddPaymentMethod _self;
  final $Res Function(_AddPaymentMethod) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentMethod = null,Object? orders = null,Object? totalQuantity = null,Object? totalPrice = null,}) {
  return _then(_AddPaymentMethod(
null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AddNominal implements OrderEvent {
  const _AddNominal(this.nominalBayar);
  

 final  int nominalBayar;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddNominalCopyWith<_AddNominal> get copyWith => __$AddNominalCopyWithImpl<_AddNominal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddNominal&&(identical(other.nominalBayar, nominalBayar) || other.nominalBayar == nominalBayar));
}


@override
int get hashCode => Object.hash(runtimeType,nominalBayar);

@override
String toString() {
  return 'OrderEvent.addNominal(nominalBayar: $nominalBayar)';
}


}

/// @nodoc
abstract mixin class _$AddNominalCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$AddNominalCopyWith(_AddNominal value, $Res Function(_AddNominal) _then) = __$AddNominalCopyWithImpl;
@useResult
$Res call({
 int nominalBayar
});




}
/// @nodoc
class __$AddNominalCopyWithImpl<$Res>
    implements _$AddNominalCopyWith<$Res> {
  __$AddNominalCopyWithImpl(this._self, this._then);

  final _AddNominal _self;
  final $Res Function(_AddNominal) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? nominalBayar = null,}) {
  return _then(_AddNominal(
null == nominalBayar ? _self.nominalBayar : nominalBayar // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AddOrder implements OrderEvent {
  const _AddOrder(this.order);
  

 final  OrderRequestModel order;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddOrderCopyWith<_AddOrder> get copyWith => __$AddOrderCopyWithImpl<_AddOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddOrder&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'OrderEvent.addOrder(order: $order)';
}


}

/// @nodoc
abstract mixin class _$AddOrderCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$AddOrderCopyWith(_AddOrder value, $Res Function(_AddOrder) _then) = __$AddOrderCopyWithImpl;
@useResult
$Res call({
 OrderRequestModel order
});




}
/// @nodoc
class __$AddOrderCopyWithImpl<$Res>
    implements _$AddOrderCopyWith<$Res> {
  __$AddOrderCopyWithImpl(this._self, this._then);

  final _AddOrder _self;
  final $Res Function(_AddOrder) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(_AddOrder(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderRequestModel,
  ));
}


}

/// @nodoc
mixin _$OrderState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderState()';
}


}

/// @nodoc
class $OrderStateCopyWith<$Res>  {
$OrderStateCopyWith(OrderState _, $Res Function(OrderState) __);
}


/// @nodoc


class Initial implements OrderState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderState.initial()';
}


}




/// @nodoc


class Loading implements OrderState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderState.loading()';
}


}




/// @nodoc


class Success implements OrderState {
  const Success(this.paymentMethod, this.nominalBayar, final  List<OrderItem> orders, this.totalQuantity, this.totalPrice): _orders = orders;
  

 final  String paymentMethod;
 final  int nominalBayar;
 final  List<OrderItem> _orders;
 List<OrderItem> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

 final  int totalQuantity;
 final  int totalPrice;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.nominalBayar, nominalBayar) || other.nominalBayar == nominalBayar)&&const DeepCollectionEquality().equals(other._orders, _orders)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice));
}


@override
int get hashCode => Object.hash(runtimeType,paymentMethod,nominalBayar,const DeepCollectionEquality().hash(_orders),totalQuantity,totalPrice);

@override
String toString() {
  return 'OrderState.success(paymentMethod: $paymentMethod, nominalBayar: $nominalBayar, orders: $orders, totalQuantity: $totalQuantity, totalPrice: $totalPrice)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 String paymentMethod, int nominalBayar, List<OrderItem> orders, int totalQuantity, int totalPrice
});




}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentMethod = null,Object? nominalBayar = null,Object? orders = null,Object? totalQuantity = null,Object? totalPrice = null,}) {
  return _then(Success(
null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,null == nominalBayar ? _self.nominalBayar : nominalBayar // ignore: cast_nullable_to_non_nullable
as int,null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class Failure implements OrderState {
  const Failure(this.message);
  

 final  String message;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OrderState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddOrderSuccess implements OrderState {
  const AddOrderSuccess(this.order);
  

 final  OrderResponseModel order;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddOrderSuccessCopyWith<AddOrderSuccess> get copyWith => _$AddOrderSuccessCopyWithImpl<AddOrderSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddOrderSuccess&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'OrderState.addOrderSuccess(order: $order)';
}


}

/// @nodoc
abstract mixin class $AddOrderSuccessCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory $AddOrderSuccessCopyWith(AddOrderSuccess value, $Res Function(AddOrderSuccess) _then) = _$AddOrderSuccessCopyWithImpl;
@useResult
$Res call({
 OrderResponseModel order
});




}
/// @nodoc
class _$AddOrderSuccessCopyWithImpl<$Res>
    implements $AddOrderSuccessCopyWith<$Res> {
  _$AddOrderSuccessCopyWithImpl(this._self, this._then);

  final AddOrderSuccess _self;
  final $Res Function(AddOrderSuccess) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(AddOrderSuccess(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderResponseModel,
  ));
}


}

// dart format on
