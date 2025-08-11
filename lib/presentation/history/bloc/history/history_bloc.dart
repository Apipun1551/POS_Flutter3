import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic23pos_flutter/data/datasource/order_remote_datasource.dart';
import 'package:fic23pos_flutter/data/models/response/history_response_model.dart';

part 'history_bloc.freezed.dart';
part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  HistoryBloc(this.orderRemoteDatasource) : super(Initial()) {
    on<HistoryEvent>((event, emit) async {
      emit(const Loading());
      final result = await orderRemoteDatasource.getOrders();
      result.fold(
        (failure) => emit(Failure(failure)),
        (success) => emit(Success(success)),
      );
    });
  }
}
