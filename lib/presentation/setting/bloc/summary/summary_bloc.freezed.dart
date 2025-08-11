// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SummaryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryEvent()';
}


}

/// @nodoc
class $SummaryEventCopyWith<$Res>  {
$SummaryEventCopyWith(SummaryEvent _, $Res Function(SummaryEvent) __);
}


/// @nodoc


class _Started implements SummaryEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryEvent.started()';
}


}




/// @nodoc


class _GetSummary implements SummaryEvent {
  const _GetSummary(this.startDate, this.endDate);
  

 final  String startDate;
 final  String endDate;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetSummaryCopyWith<_GetSummary> get copyWith => __$GetSummaryCopyWithImpl<_GetSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetSummary&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate);

@override
String toString() {
  return 'SummaryEvent.getSummary(startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$GetSummaryCopyWith<$Res> implements $SummaryEventCopyWith<$Res> {
  factory _$GetSummaryCopyWith(_GetSummary value, $Res Function(_GetSummary) _then) = __$GetSummaryCopyWithImpl;
@useResult
$Res call({
 String startDate, String endDate
});




}
/// @nodoc
class __$GetSummaryCopyWithImpl<$Res>
    implements _$GetSummaryCopyWith<$Res> {
  __$GetSummaryCopyWithImpl(this._self, this._then);

  final _GetSummary _self;
  final $Res Function(_GetSummary) _then;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? startDate = null,Object? endDate = null,}) {
  return _then(_GetSummary(
null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SummaryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryState()';
}


}

/// @nodoc
class $SummaryStateCopyWith<$Res>  {
$SummaryStateCopyWith(SummaryState _, $Res Function(SummaryState) __);
}


/// @nodoc


class Initial implements SummaryState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryState.initial()';
}


}




/// @nodoc


class Loading implements SummaryState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryState.loading()';
}


}




/// @nodoc


class Loaded implements SummaryState {
  const Loaded(this.summary);
  

 final  SummaryResponseModel summary;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode => Object.hash(runtimeType,summary);

@override
String toString() {
  return 'SummaryState.loaded(summary: $summary)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $SummaryStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 SummaryResponseModel summary
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summary = null,}) {
  return _then(Loaded(
null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as SummaryResponseModel,
  ));
}


}

/// @nodoc


class Error implements SummaryState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of SummaryState
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
  return 'SummaryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $SummaryStateCopyWith<$Res> {
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

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
