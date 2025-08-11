// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_sales_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductSalesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSalesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductSalesEvent()';
}


}

/// @nodoc
class $ProductSalesEventCopyWith<$Res>  {
$ProductSalesEventCopyWith(ProductSalesEvent _, $Res Function(ProductSalesEvent) __);
}


/// @nodoc


class _Started implements ProductSalesEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductSalesEvent.started()';
}


}




/// @nodoc


class _GetProductSalesReport implements ProductSalesEvent {
  const _GetProductSalesReport(this.startDate, this.endDate);
  

 final  String startDate;
 final  String endDate;

/// Create a copy of ProductSalesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetProductSalesReportCopyWith<_GetProductSalesReport> get copyWith => __$GetProductSalesReportCopyWithImpl<_GetProductSalesReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetProductSalesReport&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate);

@override
String toString() {
  return 'ProductSalesEvent.getProductSalesReport(startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$GetProductSalesReportCopyWith<$Res> implements $ProductSalesEventCopyWith<$Res> {
  factory _$GetProductSalesReportCopyWith(_GetProductSalesReport value, $Res Function(_GetProductSalesReport) _then) = __$GetProductSalesReportCopyWithImpl;
@useResult
$Res call({
 String startDate, String endDate
});




}
/// @nodoc
class __$GetProductSalesReportCopyWithImpl<$Res>
    implements _$GetProductSalesReportCopyWith<$Res> {
  __$GetProductSalesReportCopyWithImpl(this._self, this._then);

  final _GetProductSalesReport _self;
  final $Res Function(_GetProductSalesReport) _then;

/// Create a copy of ProductSalesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? startDate = null,Object? endDate = null,}) {
  return _then(_GetProductSalesReport(
null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ProductSalesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSalesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductSalesState()';
}


}

/// @nodoc
class $ProductSalesStateCopyWith<$Res>  {
$ProductSalesStateCopyWith(ProductSalesState _, $Res Function(ProductSalesState) __);
}


/// @nodoc


class Initial implements ProductSalesState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductSalesState.initial()';
}


}




/// @nodoc


class Loading implements ProductSalesState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductSalesState.loading()';
}


}




/// @nodoc


class Loaded implements ProductSalesState {
  const Loaded(this.productSales);
  

 final  ProductSalesResponseModel productSales;

/// Create a copy of ProductSalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&(identical(other.productSales, productSales) || other.productSales == productSales));
}


@override
int get hashCode => Object.hash(runtimeType,productSales);

@override
String toString() {
  return 'ProductSalesState.loaded(productSales: $productSales)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $ProductSalesStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 ProductSalesResponseModel productSales
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of ProductSalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productSales = null,}) {
  return _then(Loaded(
null == productSales ? _self.productSales : productSales // ignore: cast_nullable_to_non_nullable
as ProductSalesResponseModel,
  ));
}


}

/// @nodoc


class Error implements ProductSalesState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of ProductSalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProductSalesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $ProductSalesStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of ProductSalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
